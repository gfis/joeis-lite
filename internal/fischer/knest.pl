#!perl

# Extract parameters for known divisibility functions
# 2023-03-01, Georg Fischer: copied from sigma0.pl
#
#:# Usage:
#:#   perl prodet.pl [-d debug] [-f ofter_file] jcat25.txt > output.seq4
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#:#     -f  file with aseqno, offset1, terms (default $(COMMON)/joeis_ofter.txt)
#:# Reads ofter_file for implemented jOEIS sequences with their offsets and first terms
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $line = "";
my ($aseqno, $callcode, $offset, $superclass, $name, @rest);
$callcode = "sigma0";
my $rseqno;
my $ofter_file = "../../../OEIS-mat/common/joeis_ofter.txt";
my $debug   = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-cc}i) {
        $callcode   = shift(@ARGV);
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } elsif ($opt   =~ m{\-f}  ) {
        $ofter_file = shift(@ARGV);
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
my %known = qw(
    A001222 bigOmega
    A001221 omega
    A001157 sigma_2
    A001158 sigma_3
    A046523 xxx
    A006530 largestPrimeFactor
    A000120 bitcount
    A000720 PrimePi
    A001414 sopfr
    A020639 leastPrimeFactor
    A000005 sigma0
    A000010 phi
    A000203 sigma
    A007088 toBinary
    A007947 rad
    A007953 digitSum
    A008472 sopf
    A070939 bitLength
    A007814 valuation
    A000035 mod2
    A008683 moebius
    A000045 fibonacci
    A000196 sqrt
    A007953 digitsum
    A007954 digitproduct
    A007955 pod
    A007913 core
    );
#   A007947 squareFreeKernel

my $nok = "";
my $funct = "";
while (<>) {
    s/\s+\Z//; # chompr
    $line = $_;
    next if $line !~ m{\A\%[NFC]};  # no formula
    next if $line !~ m{a\(n\) *\=}; # no "a(n)="
    if ($line =~ s{\A\%[NFC] (A\d+) a\(n\) *\= *}{$1\t\=}) { # remove "a(n)", keep a chain "= expr1 = expr2 ..."
        ($aseqno, $name) = split(/\t/, $line);
        $nok = "";
        $rseqno = "A000000";
        $name =~ s{\bOmega\b}{bigOmega}g;
        $name =~ s{\b(mobius|möbius|mu)\b}{moebius}ig;
        if (0) {
        } elsif ( 0 #           1                                                                         1      2    3   4         4   3 2
            #   || ($name =~ m{\= *(A001222|bigomega|A001221|omega|A000005|tau|A000010|phi|A000203|sigma_?\d*)[\(\[](A\d+(\(n([\+\-]\d+)?\))?)[\)\]] *[\.\;\,\=]}i) # Jaguar
            #   || ($name =~ m{\= *(A020639|leastPrimeFactor|A007947|squareFreeKernel|rad|xxxxxxxxxxxxxxxxxxx)[\(\[](A\d+(\(n([\+\-]\d+)?\))?)[\)\]] *[\.\;\,\=]}i) # Jaguar
                || ($name =~ m{\= *(A000120|bitcount|A070939|A000523|bitlength|A007953|digitsum|A007088|tobinary)[\(\[](A\d+(\(n([\+\-]\d+)?\))?)[\)\]] *[\.\;\,\=]}i)
                || ($name =~ m{\= *(A000045|fibonacci|A007913|core|A001414|sopfr|A007955|pod)[\(\[](A\d+(\(n([\+\-]\d+)?\))?)[\)\]] *[\.\;\,\=]}i)
            #   || ($name =~ m{\= *(A000720|PrimePi|pi)[\(\[](A\d+(\(n([\+\-]\d+)?\))?)[\)\]] *[\.\;\,\=]}i)
            #   || ($name =~ m{\= *(A008472|sopf|A006530|Gpf|largestPrimeFacor|A046523|xxxxxxxx)[\(\[](A\d+(\(n([\+\-]\d+)?\))?)[\)\]] *[\.\;\,\=]}i) # Jaguar
                ) {
            $funct  = $1; # aseqno or function
            $rseqno = $2 || "A000001";
            $rseqno =~ s{\A(A\d+).*}{$1}; # keep aseqno only
            if (0) {
            } elsif ($funct =~ m{\AA}) {
                $funct = $known{$funct} || "undef"; # replace by function name
            }
            $funct = lc($funct); # force to lowercase
            $callcode = "knest";
            if (0) {
            } elsif ($funct eq "tau") {
                $funct = "Jaguar.factor(super.next()).sigma0()";
            } elsif ($funct =~ m{\Asigma(.*)}) {
                my $app = $1;
                $app =~ s{\_?}{};
                if (0) {
                } elsif ($app eq "0") { # ok
                    $funct = "Jaguar.factor(super.next()).sigma0()";
                } elsif ($app eq "1") {
                    $funct = "Jaguar.factor(super.next()).sigma()";
                } elsif ($app =~ m{\A(\d+)}) {
                    $funct = "Jaguar.factor(super.next()).sigma($1)";
                } else {
                    $funct = "Jaguar.factor(super.next()).sigma()";
                }
            } elsif ($funct eq "bigomega") {
                $funct = "Z.valueOf(Jaguar.factor(super.next().bigOmega())";
            } elsif ($funct eq "core") { # ok
                $funct = "Jaguar.factor(super.next()).core()";
            } elsif ($funct eq "gpf" or $funct eq "largestprimefactor") {
                $funct = "Jaguar.factor(super.next()).largestPrimeFactor()";
            } elsif ($funct eq "lpf" or $funct eq "leastprimefactor") {
                $funct = "Jaguar.factor(super.next()).leastPrimeFactor()";
            } elsif ($funct eq "omega") { # ok
                $funct = "Z.valueOf(Jaguar.factor(super.next().omega())";
            } elsif ($funct eq "phi") { #
            #   $funct = "Euler.phi(super.next())";
                $funct = "Jaguar.factor(super.next()).phi()";
            } elsif ($funct eq "pod") {
                $funct = "Jaguar.factor(super.next()).pod()";
            } elsif ($funct eq "rad") {
                $funct = "Jaguar.factor(super.next()).squareFreeKernel()";
            } elsif ($funct eq "sopfr") { #
                $funct = "Jaguar.factor(super.next()).sopfr()";

            } elsif ($funct eq "bitcount") { #
                $funct = "Z.valueOf(super.next().bitCount())";
            } elsif ($funct eq "bitlength") { #
                $funct = "Z.valueOf(super.next().bitLength())";
            } elsif ($funct eq "digitsum") { #
                $funct = "Z.valueOf(ZUtils.digitSum(super.next()))";
            } elsif ($funct eq "fibonacci") { #
                $funct = "Fibonacci.fibonacci(super.next().intValue())";
            } elsif ($funct eq "tobinary") { #
                $funct = "new Z(super.next().toString(2))";
            } else {
                $nok = "fun";
            }
            if ($funct eq "undef") {
                $nok = $funct;
            }
            &output();
        } else {
        } # no such name
    } # no "a(n) ="
} # while <>
#================================
sub output { # global $line, @periods, $reason
    $offset = 0;
    if (defined($ofters{$rseqno})) { # found and implemented in jOEIS {
        $offset = $ofters{$rseqno};
        $offset =~ s{\t.*}{}; # keep offset only
    } elsif ($nok eq "") {
        $nok = "nyi";
    }
    if ($nok eq "") {
        print        join("\t", $aseqno, $callcode, $offset, $rseqno, $funct, "", $name) . "\n";
    } else {
        print STDERR join("\t", $aseqno, $callcode, $offset, $rseqno, $nok, $funct, "", $name) . "\n";
    }
} # output
#--------
__DATA__
A104352 nyi L   Number of divisors of A104350(n).       nonn,synth      2..40   nyi     _Reinhard Zumkeller_, Mar 06 2005
A104361 nyi Ft  Number of divisors of A104357(n) = A104350(n) - 1.      nonn,changed,   2..145  nyi     _Reinhard Zumkeller_, Mar 06 2005
A104369 nyi Ft  Number of divisors of A104365(n) = A104350(n) + 1.      nonn,changed,   1..141  nyi     _Reinhard Zumkeller_, Mar 06 2005
A105191 nyi t   Number of divisors of n100000000001.    nonn,base,synth 0..74   nyi     _Parthasarathy Nambi_, Apr 11 2005
A105192 nyi     Number of divisors of n101.     nonn,base,synth 0..111  nyi     _Parthasarathy Nambi_, Apr 11 2005
A105193 nyi t   Number of divisors of n1001.    nonn,base,synth 0..81   nyi     _Parthasarathy Nambi_, Apr 11 2005