#!perl

# Split or join lines for mult.gen
# @(#) $Id$
# 2022-07-21, Georg Fischer
#
#:# Usage:
#:#     perl multsplit.pl [-j] mult3.man > mult.gen
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $join = 0;
my $debug = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{j}) {
        $join      = 1;
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my ($aseqno, $callcode, $offset, $expr, @rest);
if ($join == 0) { # split
    while (<>) {
        next if ! m{\AA\d};
        s/\s+\Z//; # chompr
        ($aseqno, $callcode, $offset, $expr, @rest) = split(/\t/);
        $rest[7] = ""; # clear name
        print join("\t", $aseqno, $callcode, $offset) . "\n"
            . ($callcode eq "mult" ? "#-------->" : "#") . " $expr\n# "
            . join("", @rest) . "\n\n"
    } # while <>
} else { # -j = join
    my $buffer = "";
    while (<>) {
        s/\s+\Z//; # chompr
        next if ! m{\S};
        my $line = $_;
        if ($line !~ m{\A\#}) {
            print "$buffer\n";
            $buffer = $line;
        } else {
            $line =~ s{\A\#+(\-+\>)? *}{};
            $buffer .= "\t$line";
        }
    }
    print "\n";
} # join
#--------------------------------------------
__DATA__
A001511 Multiplicative with a(2^k) = k + 1, a(p^k) = 1 for any odd prime p. - _Franklin T. Adams-Watters_, Jun 09 2009
A327937 Multiplicative with p^(p-1) if e >= p, otherwise a(p^e) = p^e.
