#!perl

# Extract parameters for SquareDigitSequence, A053880 ff.
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
$callcode = "squaredig4";
# while (<DATA>) { # from joeis_names.txt
while (<>) { # from joeis_names.txt
    s/\s+\Z//; # chompr
    $line = $_;
    ($aseqno, $superclass, $name, @rest) = split(/\t/, $line);
    next if $superclass ne "null";
    if (0) {
    } elsif ($name =~ m{\A(Numbers \w such that \w\^2 contains only digits|Squares composed of digits)}) {
        my $mask = (substr($1, 0, 4) eq "Numb") ? 4 : 5;
        $name =~ m{digits +\{([\d\, ]+)};
        my $subset = $1;
        $subset =~ s{ }{}g;
        my $zeroes = ($name =~ m{not ending with zero}) ? 8 : 0;
        print join("\t", $aseqno, "$callcode", $offset, 10, $mask + $zeroes, $subset, $name) . "\n";
    }
} # while <>
__DATA__
A053880	null	Numbers k such that k^2 contains only digits {1,2,4}.	nonn,base,changed,synth	1..28	nyi
A053881	null	Squares composed of digits {1,2,4}.	nonn,base,synth	1..20	nyi
A053882	null	Numbers k such that k^2 contains only digits {1,2,6}.	nonn,base,more,changed,synth	1..17	nyi
A053883	null	Squares composed of digits {1,2,6}.	nonn,base,synth	1..15	nyi
