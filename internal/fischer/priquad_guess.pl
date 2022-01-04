#!perl

# priquad_guess.pl - guess residues for sequences computed with the MMA program QuadPrimes2[]
# 2022-01-03, Georg Fischer
# partly copied from OEIS-mat/common/extract_info.pl
#
#:# Usage:
#:#     perl priquad_guess.pl priquad3.gen > output.seq4
#-----------------------------------------------
use strict;
use integer;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday) = gmtime (time);
my $utc_stamp = sprintf ("%04d-%02d-%02dT%02d:%02d:%02d\z"
        , $year + 1900, $mon + 1, $mday, $hour, $min, $sec);

my $read_len_max = 100000000; # 100 MB
my $read_len_min =      8000; # stripped has about 960 max.
my $bfile_dir = "../../../OEIS-mat/common/bfile";
my $access = "1971-01-01 00:00:00"; # modification timestamp from the file
my $buffer; # contains the whole file
my $filesize  = 0; # file size in bytes from the operating system
my $index1 = 1;

my ($line);
my $callcode = "priguess";
my $debug = 0;
my $action = "b";

my ($aseqno, $callcode, $offset, $discr, $polar, $ax2, $bxy, $cy2, $superclass, $name, @rest);

while (<>) {
# while (<DATA>) {
    $line = $_;
    $line =~ s{\s+\Z}{}; # chompr
    ($aseqno, $callcode, $offset, $discr, $polar, $ax2, $bxy, $cy2, $superclass, $name, @rest) = split(/\t/, $line);
    $discr = abs($discr);
    if ($discr % 4 == 0) {
        $discr /= 4;
    }
    # $discr *= 4;
    if ($superclass eq "nyi") {
        my $list = &extract_from_bfile("$bfile_dir/b" . substr($aseqno, 1) . ".txt");
        print join("\t", $aseqno, "pricongr", 1, abs($discr), 0, $list, $ax2, $bxy, $cy2) . "\n";
    }
} # while <>
#---------------------------
sub extract_from_bfile {
    my ($filename) = @_;
    &read_file($filename, $read_len_max); # sets $access, $buffer, $filesize
    my $index;
    my $term;
    my %hash = ();
    foreach my $line (split(/\n/, $buffer)) {
        if ($line =~ m{\A\s*(\-?\d+)\s+(\-?\d+)}o) { # index space term
            ($index, $term) = ($1, $2);
            if ($index >= $index1) {
                my $res = $term % $discr;
                $hash{$res} = 1;
            }
        }
    } # foreach $line
    my @list = sort {$a <=> $b} keys(%hash);
    return join(",", @list);
} # extract_from_bfile
#----------------------
sub read_file { # returns in global $access, $buffer, $filesize
    my ($filename, $read_len) = @_;
    if ($debug > 0) {
        print STDERR "read_file \"$filename\", $read_len bytes\n";
    }
    open(FIL, "<", $filename) or die "cannot read $filename\n";
    my ($dev, $ino, $mode, $nlink, $uid, $gid, $rdev, $size, $atime
        , $mtime, $ctime, $blksize, $blocks) = stat(FIL);
    ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday) = gmtime ($mtime);
    $access = sprintf ("%04d-%02d-%02d %02d:%02d:%02d"
        , $year + 1900, $mon + 1, $mday, $hour, $min, $sec); # in UTC: "2019-01-23 08:07:00"
    read(FIL, $buffer, $read_len); # 100 MB, should be less than 10 MB
    $filesize = $size;
    close(FIL);
} # read_file
#---------------------------
__DATA__
A106905	priquad2	0	-52	1	2	2	7	nyi	QuadPrimes2[2, 2, 7, 10000]
A106906	priquad2	0	-52	1	2	-2	7	CongruenceForm	QuadPrimes2[2, -2, 7, 10000]
A106907	priquad2	0	-55	1	4	3	4	nyi	QuadPrimes2[4, 3, 4, 10000]
A106908	priquad2	0	-55	2	4	3	4	nyi	Union[QuadPrimes2[4, 3, 4, 10000], QuadPrimes2[4, -3, 4, 10000]]
A106909	priquad2	0	-55	1	4	-3	4	nyi	QuadPrimes2[4, -3, 4, 10000]
A106910	priquad2	0	-55	1	2	1	7	nyi	QuadPrimes2[2, 1, 7, 10000]
