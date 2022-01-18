#!perl

# Extract parameters for SquareDigitSequence, A053880 ff.
# 2022-01-18: triangular numbers
# 2022-01-09, Georg Fischer: copied from invbinom.pl
#
#:# Usage:
#:#   grep -E "^digits +\{[0-9]" $(COMMON)/joeis_names.txt \
#:#   | perl squaredig4.pl [-d debug] $(COMMON)/joeis_names.txt > output.seq4
#:#        -d  debugging level (0=none (default), 1=some, 2=more)
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $line = "";
my ($aseqno, $superclass, $callcode, $name, @rest);
my ($rseqno);
my $debug   = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $offset = 1;
my $mask;
my $subset;
my $zeroes;
# while (<DATA>) { # from joeis_names.txt
while (<>) { # from joeis_names.txt
    s/\s+\Z//; # chompr
    $line = $_;
    ($aseqno, $superclass, $name, @rest) = split(/\t/, $line);
    next if $superclass ne "null";
    $zeroes = 0;
    if (0) {
    } elsif ($name =~ m{\A(Numbers \w such that \w\^2 contains only digits|Squares composed of digits)}) {
        $mask = (substr($1, 0, 4) eq "Numb") ? 4 : 5;
        $name =~ m{digits +\{([\d\, ]+)};
        $subset = $1;
        $subset =~ s{ }{}g;
        $zeroes = ($name =~ m{not ending with zero}) ? 8 : 0;
        print join("\t", $aseqno, "squaredig4", $offset, 10, $mask + $zeroes, $subset, $name) . "\n";
    } elsif ($name =~ m{\A(Numbers \w such that the \w\-th triangular number contains only digits|Triangular numbers composed of digits)}) {
        $mask = (substr($1, 0, 4) eq "Numb") ? 16 : 17;
        $name =~ m{digits +\{([\d\, ]+)};
        $subset = $1;
        $subset =~ s{ }{}g;
        print join("\t", $aseqno, "triangdig4", $offset, 10, $mask + $zeroes, $subset, $name) . "\n";
    }
} # while <>
__DATA__
A053880	null	Numbers k such that k^2 contains only digits {1,2,4}.	nonn,base,changed,synth	1..28	nyi
A053881	null	Squares composed of digits {1,2,4}.	nonn,base,synth	1..20	nyi
A053882	null	Numbers k such that k^2 contains only digits {1,2,6}.	nonn,base,more,changed,synth	1..17	nyi
A053883	null	Squares composed of digits {1,2,6}.	nonn,base,synth	1..15	nyi

A119033	null	Triangular numbers composed of digits {0,1,2}.	nonn,base,synth	1..25	nyi
A119034	null	Numbers k such that the k-th triangular number contains only digits {0,1,2}.	nonn,base,changed,synth	1..31	nyi
