#!perl

# Find rebase sequences (cf. A000695)
# @(#) $Id$
# 2020-12-01, Georg Fischer
#
#:# Usage:
#:#   perl rebase.pl [-d debug] [-n noterms] > outfile
#:#       -d debugging level: 0 (none), 1 (some), 2 (more)
#:#       -n number of terms to be generated (default: 64)
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp  = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);
if (0 && scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $debug   = 1;
my $noterms = 64;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{n}) {
        $noterms   = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
my $JAVA   = "make -s runjava CLASS=irvine.oeis.a037.A037454";
my $COMMON = "../../../OEIS-mat/common";
my $line;
my $cmd;
my $aseqno = "A999999";
my $newseq = 999000;

for (my $baseFrom = 2; $baseFrom <= 20; $baseFrom ++) {
for (my $baseTo   = 2; $baseTo   <= 20; $baseTo   ++) {
    if ($baseFrom != $baseTo) {
        my $cmd = "$JAVA ARGS=\"$baseFrom $baseTo $noterms\"";
        my $result   = `$cmd`;
        $result      =~ s{\s}{}g;
        my $termlist = $result;
        $termlist =~ s{\A(0\,)?(1\,)?}{};
        print join("\t", "# $baseFrom", $baseTo, $result) . "\n";
        $cmd = "grep -P \"\\AA\\d+\\t\\d+\\t(0\\,)?(1\\,)?$termlist\" $COMMON/bfdata.txt";
        print "# cmd=$cmd\n";
        my $bfdata = `$cmd`;
        if (length($bfdata) >= 4) {
            foreach my $line (split(/\n/, $bfdata)) {
                if ($line =~ m{\A(A\d+)}) {
                    $aseqno = $1;
                    $cmd = "grep -E \"^$aseqno\" $COMMON/joeis_names.txt";
                    $result = `$cmd`;
                    $result =~ s{\s+\Z}{}; # chompr
                    my ($rseqno, $superclass, $name, $keyword, $range, $pattern) = split(/\t/, $result);
                    print join("\t", $aseqno, "rebase", 0, $baseFrom, $baseTo, $name, $superclass, $pattern, $range) . "\n";
                } # if line not empty
            } # foreach
        } else {
            $newseq ++;
            print join("\t", "A" . $newseq, "rebase", 0, $baseFrom, $baseTo, "new") . "\n";
        }
    }
} # for baseTo
} # for baseFrom
#---------------------------------------
__DATA__
