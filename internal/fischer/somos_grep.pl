#!perl

# Grep SOmos-like recurrences from jcat25.txt
# @(#) $Id$
# 2022-05-31, Georg Fischer
#
#:# Usage:
#:# grep -E "^\%[NFC]" $(COMMON)/jcat25.txt \
#:# | perl somos_grep.pl [-A] > output.seq4 
#:#   -A do not generate when there are foreign A-numbers
#:#
#:# Reads terms from $(COMMON)/asdata.txt.
#:# Column parm2 must contain "m:inits", 
#:# where m is the number of initial terms,
#:# and inits must be a substring of the data list with sufficient length
#-------------------------------------------------
use strict;
use integer;
use warnings;

my $debug = 0;
my $withoutA = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug      = shift(@ARGV);
    } elsif ($opt  =~ m{A}) {
        $withoutA   = 1;
    }
} # while $opt

my $esc = "b";
my $Esc = "B";
my $callcode;
my $nok;
while (<>) {
    my $line = $_;
    $line =~ s/\s+\Z//; # chompr
    if ($line =~ m{\A\%[NFC] (A\d+) +(.*)}) {
        my ($aseqno, $name) = ($1, $2);
        $nok = "";
        $name =~ s{ mod(ulo)? }                      {\%}g;
        $name =~ s{ XOR }                            {\§}ig;
        $name =~ s{floor\(([^\)]+)\)}                {$1}ig; # floor(x) -> x
        $name =~ s{\..*}                             {}; # delete all after "."
        $name =~ s{( +for +n| and | with ).*\Z}      {}; # remove "for n > ...", " and ..."
        $name =~ s{( *a\(\d+\) *\= *\-?\d+ *[\,\;\:])+}  {}; # remove leading "a(1)=1, a(2)=2 ..."
        $name =~ s{(\, *a\(\d+\) *\= *\-?\d+)+}      {}; # remove trailing ", a(1)=1, a(2)=2 ..."
        my $order = 0;
        my $nshift = 0;
        my $expr = "";
        my $rest = "";
        my $min = 0;
        my $max = 0;
        if (0) {
        #                         1         1       2                           23  3
        } elsif ($name =~ m{\Aa\(n([\-\+]\d+)?\) *\=([ anA\d\(\)\+\-\*\/\%\§\^]+)(.*)\Z}) {
            ($nshift, $expr, $rest) = ($1 || 0, $2 || "", $3 || "");
            $nshift =~ s{\A\+}{};
            if (0) {
            } elsif ($rest =~ m{\A(if|when|such|\!)}) {
                $nok = "if,when,such,!";
            } elsif ($rest =~ m{\A *([\.\:\;]| *\Z)}) {
                $expr =~ s{ }                  {}g;
                map {
                    my $d = $_;
                    $min = $min < $d ? $min : $d + 0;
                    $max = $max > $d ? $max : $d + 0;
                } ($expr =~ m{a\(n([+\-]\d+)\)}g);
                $expr =~ s{A(\d+)\(n\)}        {$Esc${1}_0}g;
                $expr =~ s{A(\d+)\(n\+(\d+)\)} {$Esc${1}__$2}g;
                $expr =~ s{A(\d+)\(n\-(\d+)\)} {$Esc${1}_$2}g;
                $expr =~ s{\)([na$Esc])}       {\)\*$1}g;  # )b -> )*b
                $expr =~ s{(\d)(\(|a)}         {$1\*$2}g;  # 3( -> 3*(, 3b -> 3*b
                $expr =~ s{\)\(}               {\)\*\(}g;  # )( -> )*(
                $expr =~ s{a\(n\)}             {${esc}_0}g;
                $expr =~ s{a\(n\+(\d+)\)}      {${esc}__$1}g;
                $expr =~ s{a\(n\-(\d+)\)}      {${esc}_$1}g;
                if (   ($expr !~ m{(a|A\d+)})   # no remaining a(), A123()
                    && ($expr =~ m{[\d\)n]\Z})  # only ")", digit, n at the end, and with some a(n...)
                    && ($expr =~ m{${esc}_\d})  # at least 1 recurrence element on the right
                    ) {
                    $expr = &unshield(&zexpr($expr));
                    if (length($expr) > 1024) {
                        $nok = "expr too long";
                    }
                    if ($withoutA && ($expr =~ m{mA\d+})) {
                        $nok = "with A-number";
                    }
                } else {
                    $nok = "remaining Aa()";
                }
            } else {
                $nok = "trailing words";
            }
            if (length($nok) == 0) {
                $order = $max-$min; # aseqno   callcode  offset parm1   parm2    parm3   parm4  parm5
                print  join("\t",     $aseqno, "cordrec"   , 0, $order, $nshift, "xxxx", $expr, substr($name, 0, 64)) . "\n";
            } else {
                print STDERR join("\t", $aseqno, "?nok", 0, $order, $nshift, "$nok", $expr, $name) . "\n";
            }
            # with recurrence equation
        } else {
            # no equation a(n) = ...
        }
    } # proper jcat25 line
} # while
#----
sub unshield {
    my ($expr) = @_;
    $expr =~ s{${Esc}(\d+)_0}       {mA$1m0}g;
    $expr =~ s{${Esc}(\d+)__(\d+)}  {mA$1p$2}g;
    $expr =~ s{${Esc}(\d+)_(\d+)}   {mA$1m$2}g;
    $expr =~ s{${esc}_0}            {a\(n\)}g;
    $expr =~ s{${esc}__(\d+)}       {a\(n\+$1\)}g;
    $expr =~ s{${esc}_(\d+)}        {a\(n\-$1\)}g;
    return $expr;
} # unshield
#----
sub zexpr { # handle divisors
    my ($expr) = @_;
    my ($numer, $denom) = ("", "");
    if (0) {
    #                       1      1    23    3    2
    } elsif ($expr =~ m{\A\(([^\)]+)\)\/(.*)\Z}) { # cut of trailing divisor
        ($numer, $denom) = ($1, $2);
        $expr = &zsum($numer) . ".divide($denom)";
    } elsif ($expr !~ m{\/}) {
        $expr = &zsum($expr);
    } else { # there was some other divisor
        $expr =~ s{\/(\n|\d+|\([\n\d\+\-\*]+\))}{\.divide\($1\)}g;
        if ($expr =~ m{\/}) { # still with "/"
            $nok = 9;
        }
    }
    return $expr;
} # zexpr
#----
sub zsum { # handle sum separated by "+" and "-"
    my ($expr) = @_;
    $expr =~ s{\-}{\+\-}g; # shield "-" = subtract
    my @parts = split(/\+/, $expr); # split on shield
    if ($parts[0] =~ m{\A(\d+|n|\(\[n\d\+\-]+\))\Z}) { # first is simple
        if (scalar(@parts) == 1) { # the only one
            $parts[0] = "Z.valueOf($parts[0])";
        } else { # switch to 2nd pos.
            my $temp = $parts[0];
            $parts[0] = $parts[1];
            $parts[1] = $temp;
        }
    } # if simple
    for (my $ipa = 0; $ipa < scalar(@parts); $ipa ++) {
        my $part = $parts[$ipa];
        if (0) {
        } elsif ($ipa == 0) {
            $parts[$ipa] =            &zprod($part);
        } elsif ($ipa == 1) {
            $parts[$ipa] =  ".add(" . &zprod($part) . ")";
        } else {
            $parts[$ipa] = ").add(" . &zprod($part) . ")";
        }
    } # for $ipa
    my $result = join("", @parts);
    # patches:
    $result =~ s{\.add\(\-}{\.subtract\(}g;
    $result =~ s{\((\d+)\.pow\(n\)\)}{Z.valueOf\($1\)\.pow\(n\)}g;
    $result =~ s{\A\.subtract}{Z\.ZERO\.subtract};
    return $result;
} # zsum
#----
sub zprod { # handle product separated by "*", put non-Z factors at the 2nd position
    my ($expr) = @_;
    $expr =~ s{\%}{\*\%}g; # shield "%" = mod
    my @parts = split(/\*/, $expr);
    if ($parts[0] =~ m{\A(\d+|n|\(\[n\d\+\-]+\))\Z}) { # first is simple
        if (scalar(@parts) == 1) { # the only one
            $parts[0] = "Z.valueOf($parts[0])";
        } else { # switch to 2nd pos.
            my $temp = $parts[0];
            $parts[0] = $parts[1];
            $parts[1] = $temp;
        }
    } # if simple
    for (my $ipa = 0; $ipa < scalar(@parts); $ipa ++) { # expand powers
        my $part = $parts[$ipa];
        $part =~ s{\^2}{\.square\(\)}g;
        $part =~ s{\^(\d+|n)}{\.pow\($1\)}g;
        if (0) {
        } elsif ($ipa == 0) {
            $parts[$ipa] =                 $part;
        } elsif ($ipa == 1) {
            $parts[$ipa] =  ".multiply(" . $part . ")";
        } else {
            $parts[$ipa] = ").multiply(" . $part . ")";
        }
    } # for $ipa
    my $result = join("", @parts);
    # patches:
    $result =~ s{\.multiply\(\%}{\.mod\(}g;
    $result =~ s{\(\.multiply\(\-(\d+)\)\)}{\(-$1\)}g;
    return $result;
} # zprod
#========
__DATA__
A141542	genrec	0	4	0	xxxx	µ1+µ2+µ3+µ4				a(n) =a(n - 1) + a(n - 2) + a(n - 3) + a(n - 4); Renormalized factorial; f(n) = a(n)*n*f(n - 1)/a(n - 1); Neo-combination: t(n, m) = f(n)/(f(n - m)*f(m))
A141609	genrec	0	3	0	xxxx	(µ1*µ2+µ1^2)/µ3				a(n)=(a(n - 1)*a(n - 2) + a(n - 1)^2)/a(n - 3)
A141827	genrec	0	1	0	xxxx	(n^3*µ1-1)/(n-1)				a(n) = (n^3*a(n-1) - 1)/(n - 1)
A141828	genrec	0	1	0	xxxx	(n^4*µ1-1)/(n-1)				a(n) = (n^4*a(n-1)-1)/(n-1)
A142703	genrec	0	2	0	xxxx	2*(n-1)*(µ1+µ2)				a(n) = 2*(n-1)*( a(n-1)+a(n-2) ) starting a(1)=a(2)=1
A142704	genrec	0	3	0	xxxx	2*n*(µ2+µ3)				a(n) = 2*n*(a(n-2) + a(n-3)) with a(0) = 0, a(1) = a(2) = 1
A157101	genrec	0	4	xxxx	n -> (µ1*µ3+µ2^2)/µ4				a(n) = (a(n-1)*a(n-3) + a(n-2)^2)/a(n-4), with a(0)=1, a(1)=-1, a(2)=-5, a(3)=-4
A158802	genrec	0	3	xxxx	n -> ((n-1)*(n-3)*µ1-µ2+µ3)/(n*(n-1))				a(n)=((n - 1)*(n - 3)*a(n - 1) - a(n - 2) + a(n - 3))/(n*(n - 1));
A159860	genrec	0	1	xxxx	n -> µ1(µ1+6)/4				a(n) = a(n - 1)(a(n - 1) + 6)/4 [From _N
