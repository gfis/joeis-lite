#!perl

# Prepare regular expressions in "Numbers such that ... is prime"
# 2021-01-10, Georg Fischer: copied from suchprim.pl
#
#:# Usage:
#:#   grep ... $(COMMON)/joeis_names.txt \
#:#   | perl proprep.pl [-d debug] [-f ofter_file] > output
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#:#     -f  file with aseqno, offset1, terms (default $(COMMON)/joeis_ofter.txt)
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $line = "";
my ($aseqno, $superclass, $callcode, @rest, $name);
my $debug   = 0;
my $offset = 0;
my $rseqno = "";
my $ofter_file = "../../../OEIS-mat/common/joeis_ofter.txt";
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
#----------------
my $terms;
my %ofters = ();
open (OFT, "<", $ofter_file) || die "cannot read $ofter_file\n";
while (<OFT>) {
    s{\s+\Z}{};
    ($aseqno, $offset, $terms) = split(/\t/);
    $terms = $terms || "";
    if ($offset < -1) { # offsets -2, -3: strange, skip these
    } else {
        $ofters{$aseqno} = "$offset\t$terms";
    }
} # while <OFT>
close(OFT);
print STDERR "# $0: " . scalar(%ofters) . " jOEIS offsets and some terms read from $ofter_file\n";
#----------------

my @parms;
while (<>) { # from joeis_names.txt
    s/\s+\Z//; # chompr
    $line = $_;
    $line =~ s{\, where R_.*}{};
    $line =~ s{ is (a )?prime}{\; is prime};
    ($aseqno, $superclass, $name, @rest) = split(/\t/, $line);
    if (defined($ofters{$aseqno})) {
        # ignore if already implemented
    } elsif ($name =~ m{\.\.\.}) {
        print STDERR "$line\n";
    } elsif ($name =~ m{Numbers ([a-z]) such that (the string |the concatenation )?([^\;]+)\; is prime(\Z|\.)}) {
        # A104912   null    Numbers k such that the string 9876543210k is prime.    nonn,base,synth 1..49   nyi
        # A104914   null    Numbers n such that the string 987654321k is prime. nonn,base,  1..10000    nyi
        my $letter = $1;
        my $expr   = $3;
        $expr =~ s{ }{}g;
        $expr =~ s{$letter}{k}g;
        $expr =~ s{R_k}{\(10^k\-1\)\/9}g;
        $expr =~ s{(\A|[\+\-])k}{${1}1\*k}g;
        $expr =~ s{[\+\-]}{~}g;
        $expr =~ s{A\d{6}}{A__}g;
        $expr =~ s{\d+}{7}g;
        my $code = $expr;
        $code = "";
      if (0) {
        $expr =~ s{\d+}{17};
        $expr =~ s{\d+}{17};
        $expr =~ s{\d+}{17};
        $expr =~ s{([\+\-])(\d+)}{\(\[\\\+\\\-\]\)\(\\d\+\)}g;
        $expr =~ s{([\*\/\(\)\^\,\!])}{\\$1}g;
        $expr =~ s{(\d+)}{\(\\d+\)}g;
        $code =~ s{\[\\\+\\\-\]\)\(\\d\+\)}{V}g; # signed value
        $code =~ s{\(\\d\+\)}{N}g; # number
        # $code =~ s{\\\+}{S}g; # "S"ign, or "A"dd ?
        # $code =~ s{\\\-}{S}g;
        $code =~ s{\\\*}{M}g;
        $code =~ s{\\\/}{D}g;
        $code =~ s{\\\^}{E}g;
        $code =~ s{\\\(}{o}g;
        $code =~ s{\\\)}{c}g;
        $code =~ s{\\\!}{F}g;
        $code = uc($code);
      }
        if ($expr !~ m{[a-z][a-z]}) {
            print join("\t", $aseqno, "proprep", 0, $expr, $code) . "\n";
        } else {
            print STDERR "$line\n";
        }
    } else {
        print STDERR "$line\n";
    } # if proper name
} # while <>
#================
__DATA__
