#!perl

# Search for a list of words in the sequence description that justifies some property
# @(#) $Id$
# 2021-10-03, Georg Fischer
#
#:# Usage:
#:#   perl justify.pl [-w word ...] infile.seq4 > outfile
#:#   Add a comment containing the word if it is found in $(COMMON)/ajson/aseqno.json
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
my @words = ();
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{w}) {
        my $word   = shift(@ARGV);
        push(@words, $word);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $COMMON = "../../../OEIS-mat/common";
my $buffer;
while(<>) {
    s/\s+\Z//; # chompr
    my $line = $_;
    my ($aseqno, $callcode, @parms) = split(/\t/);
    open(SRC, "<", "$COMMON/ajson/$aseqno.json") or die "cannot read $aseqno.json";
    # print "# read from $COMMON/ajson/$aseqno.json\n";
    while (<SRC>) {
        $buffer = $_;
        $buffer =~ s{\A\s+}{};
        foreach my $word (@words) {
            if ($buffer =~ m{$word}i) {
                print "# $aseqno\t$word\t$buffer"; # print a justifying comment
            }
        } # foreach
    } # while <SRC>
    close(SRC);
    print "$line\n"; # repeat the source line in any case
} # while <>
#---------------------------------------
__DATA__
