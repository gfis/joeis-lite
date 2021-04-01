#!perl

# Extract parameters for kdivpsum
# @(#) $Id$
# 2021-03-28, Georg Fischer: copied from posins.pl; WK=74
#
#:# Usage:
#:#     grep -E "Numbers [nk] such that [nk] \| " $(COMMON)/joeis_names.txt \
#:#     | perl $@.pl -a A056643 \
#:#     >        $@.gen
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

my $debug = 0;
my $rseqno = "A056643";

if (scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{[ar]}) {
        $rseqno    = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $line;
# A056643 null    Numbers n such that n | 4^n + 3^n + 2^n + 1^n.  nonn,synth      1..43   nyi
my ($aseqno, $callcode, $name, $keyword, $range, @rest); # records in joeis_names.txt
my $offset;

while (<>) {
    $line = $_;
    $line =~ s/\s+\Z//; # chompr
    ($aseqno, $callcode, $name, $keyword, $range, @rest) = split(/\t/, $line);
    $range =~ m{\A(\d+)};
    $offset = $1;
    $callcode = "kdivpsum";
    if ($name =~ m{\ANumbers ([nk]) such that \1 *\| *([^\.]+)\.}) {
        my ($var, $expr) = ($1, $2);
        my @list = (0); # dummy constant
        my @pows = split (/\s*\+\s*/, $expr);
        my $valid = 1;
        foreach my $pow (@pows) {
            if ($pow =~ m{\A(\d+)(\^$var)?\Z}) {
                my ($base, $nk) = ($1, $2 || "");
                if (length($nk) == 0 || $base == 1) {
                    $list[0] = $base; # replace the constant
                } else {
                    push(@list, $base);
                }
            } else { 
                $valid = 0;
            }
        } # foreach $pow
        if ($valid) {
            if ($list[0] < 0) {
                shift(@list); # remove the dummy constant
            }
            print join("\t", $aseqno, $callcode, $offset, $rseqno, join(",", @list)) . "\n";
        } else {
            print STDERR "$line\n";
        }
    } # if "Numbers ... such that"
} # while <>
#--------------------------------------------
__DATA__
A056643 null    Numbers n such that n | 4^n + 3^n + 2^n + 1^n.  nonn,synth      1..43   nyi
A056645 null    Numbers n such that n | 3^n + 2^n + 1^n.        nonn,synth      1..40   nyi
A056739 null    Numbers n such that n | 10^n + 9^n + 8^n + 7^n + 6^n + 5^n + 4^n + 3^n + 2^n + 1^n.     nonn,synth      1..39   nyi
A056741 null    Numbers n such that n | 5^n + 4^n + 3^n + 2^n + 1^n.    nonn,synth      1..47   nyi
A056745 null    Numbers n such that n | 6^n + 5^n + 4^n + 3^n + 2^n + 1^n.      nonn,synth      1..47   nyi
A056750 null    Numbers n such that n | 7^n + 6^n + 5^n + 4^n + 3^n + 2^n + 1^n.        nonn,synth      1..47   nyi
A056751 null    Numbers n such that n | 8^n + 7^n + 6^n + 5^n + 4^n + 3^n + 2^n + 1^n.  nonn,synth      1..48   nyi
A056754 null    Numbers n such that n | 9^n + 8^n + 7^n + 6^n + 5^n + 4^n + 3^n + 2^n + 1^n.    nonn,changed,synth      1..47   nyi
A057193 null    Numbers n such that n | 12^n + 11^n.    nonn,synth      1..29   nyi
A057214 null    Numbers n such that n | 10^n + 9^n + 8^n + 7^n. nonn,synth      1..42   nyi
A057232 null    Numbers n such that n | 10^n + 9^n + 8^n.       nonn,   1..53   nyi
A057233 null    Numbers n such that n | 8^n + 7^n + 6^n.        nonn,changed,   1..238  nyi
A057234 null    Numbers n such that n | 7^n + 6^n + 5^n.        nonn,synth      1..38   nyi
A057235 null    Numbers n such that n | 6^n + 5^n + 4^n.        nonn,synth      1..47   nyi
A057236 null    Numbers n such that n | 5^n + 4^n + 3^n.        nonn,synth      1..40   nyi