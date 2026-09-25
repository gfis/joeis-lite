#!perl

# Extract sha256 and size from oeisdata placeholders for b-files
# @(#) $Id$
# 2026-09-24, Georg Fischer
#
#:# usage:
#:#   find files -iname "b??????.txt" \
#:#   | perl extract_oeisdata_sha.pl [filelist] [-d level] > outputfile
#:#       -d level    debug level: none(0), some(1), more(2)
#---------------------------------
use strict;
use integer;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday) = gmtime (time);
my $utc_stamp = sprintf ("%04d-%02d-%02dT%02d:%02d:%02d\z"
        , $year + 1900, $mon + 1, $mday, $hour, $min, $sec);

# get options
my $debug      =  0; # 0 (none), 1 (some), 2 (more)
if (scalar(@ARGV) == 1 && $ARGV[0] =~ m{\A\-+\h(elp)}) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A\-})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt =~ m{\-d}) {
        $debug    = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while ARGV

my $odir = "";
while (<>) {
    s/\s+\Z//; # chompr
    my $filename = $_;
    #            1      1   2     2
    next if $filename !~ m{(A\d{3})\/b(\d{6})\.txt};
    my $adir   = lc($1);
    if ($odir ne $adir) {
        print STDERR "$filename\n";
        $odir = $adir
    }
    my $aseqno = "A$2";
    my $bfsize = "undef";
    my $sha256 = "undef";
    open(INP, "<", $filename) || die "cannot read $filename\n";
    my ($dev, $ino, $mode, $nlink, $uid, $gid, $rdev, $size, $atime, $mtime, $ctime, $blksize, $blocks) = stat(INP);
    my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday) = gmtime ($mtime);
    my $date = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday); # in UTC: "2019-01-23"
    if ($size >= 256) { # no placeholder, real b-file
        print STDERR join("no placeholder", $filename) . "\n";
        next;
    }
    while (<INP>) {
        my $line = $_;
        if (0) {
        } elsif ($line =~ m{\Aoid sha256\:(.+)}) {
            $sha256 = $1;
        } elsif ($line =~ m{\Asize (\d+)}) {
            $bfsize = $1;
        } elsif ($line =~ m{\Aversion }) {
            # ignore;
        } else {
            $sha256 = "b-file content?";
            last;
        }
    } # while <INP>
    close(INP);
    print join("\t", $aseqno, $bfsize, $sha256, $date) . "\n";
} # extract_json
__DATA__
version https://git-lfs.github.com/spec/v1
oid sha256:68545c299571efdf359fa9445d47347974f75d527126efd99b50920a908ec01f
size 791
