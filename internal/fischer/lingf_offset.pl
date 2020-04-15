#!perl

# Patch the numerator of an ogf if offset > 0
# @(#) $Id$
# 2020-04-15, Georg Fischer
#
#:# Usage:
#:#   perl lingf_offset.pl [-d debug] infile > outfile
#:#       infile has the format: A-number tab callcode tab offset tab numerator_vector 
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);
my $debug = 0;
if (scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

while (<>) {
    my $line = $_;
    $line =~ s/\s+\Z//; # chompr
    my ($aseqno, $callcode, $offset, $num, @rest) = split(/\t/, $line);
    if ($offset > 0) {
        # ensure that there are at least 'offset' leading zeroes in the numerator
        $num =~ m{\A((0\,)*)};
        my $zeroes = $1 || "";
        my $nleadz = length($zeroes) / 2;
        while ($nleadz < $offset) {
            $num = "0,$num";
            $nleadz ++;
        } # while nleadz
    } # offset > 0
    print join("\t", ($aseqno, $callcode, $offset, $num, @rest)) . "\n";
} # while <>
#--------------------------------------------
sub output {

} # output
__DATA__
