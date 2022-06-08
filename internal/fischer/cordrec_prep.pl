#!perl

# Grep (Somos-like) recurrences from jcat25.txt
# @(#) $Id$
# 2022-06-07: renamed/splitted from cordrec.pl
# 2022-06-04, Georg Fischer: copied from somos_grep.pl, but with offset support
#
#:# Usage:
#:# grep -E "^\%[NFCO]" $(COMMON)/jcat25.txt \
#:# | perl cordrec_prep.pl \
#:# | perl cordrec.pl [-A] > output.seq4 
#:#   -A do not generate when there are foreign A-numbers
#:#
#:# Offsets come at the end of a block in cat25.txt.
#:# Only the last name/expression is kept.
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
my $callcode = "cordrec";
my $nok = "";
my $offset = 0;
my $aseqno = "";
my $name   = "";
my @names  = ();
while (<>) {
    my $line = $_;
    $line =~ s/\s+\Z//; # chompr
    if (0) {
    } elsif ($line =~ m{\A\%[NFC] (A\d+) +(.*)}) { # nyi; relevant line
        ($aseqno, $name) = ($1, $2);
        if ($name ne "" and ($name !~ m{Empirical|conjecture|apparent}i) ) {
            if ($name =~ m{\Aa\(n([\-\+]\d+)?\)}) { # contains a(n...)
                $name =~ s{[^\.] +\- +_[A-Z]}{\.}; # remove author even if no "." before
                push(@names, $name); # remember several relevant names before the "O" line
            }
        }
    } elsif ($line =~ m{\A\%[O] (A\d+) +(\d+)}) { # offset line - must always be present for a A-number
        ($offset) = ($2);
        for $name (@names) { # for all expressions of this aseqno
            $nok = "";
            $name =~ s{ mod(ulo)? }                         {\%}ig;
            $name =~ s{ XOR }                               {\§}ig;
            $name =~ s{floor}                               {}ig; # floor(x) -> (x)
            $name =~ s{( for | and | with | starting )}     {\.}; # remove "for  ..."
            $name =~ s{\..*}                                {}; # delete all after "."
            $name =~ s{( *a\(\d+\) *\= *\-?\d+ *[\,\;\:])+} {}; # remove leading "a(1)=1, a(2)=2 ..."
            $name =~ s{(\, *a\(\d+\) *\= *\-?\d+)+}         {}; # remove trailing ", a(1)=1, a(2)=2 ..."
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
                $min = $nshift;
                $max = $nshift;
                if (0) {
                } elsif ($rest =~ m{\A(if|when|such|\!)}) {
                    $nok = "if,when,such,!";
                } elsif ($rest =~ m{\A *([\.\:\;]| *\Z)}) {
                    $expr =~ s{ }{}g;
                    map {
                        my $d = $_ || 0;
                        $min = $min < $d ? $min : $d + 0;
                        $max = $max > $d ? $max : $d + 0;
                    } ($expr =~ m{a\(n([+\-]\d+)?\)}g);
                    $order = $max - $min;
                    $expr =~ s{A(\d+)\(n\)}        {$Esc${1}_0}g;
                    $expr =~ s{A(\d+)\(n\+(\d+)\)} {$Esc${1}__$2}g;
                    $expr =~ s{A(\d+)\(n\-(\d+)\)} {$Esc${1}_$2}g;
                    $expr =~ s{\)([na$Esc])}       {\)\*$1}g;  # )b -> )*b
                    $expr =~ s{(\d)(\(|a)}         {$1\*$2}g;  # 3( -> 3*(, 3b -> 3*b
                    $expr =~ s{\)\(}               {\)\*\(}g;  # )( -> )*(
                    $expr =~ s{a\(n\)}             {${esc}_0}g;
                    $expr =~ s{a\(n\+(\d+)\)}      {${esc}__$1}g;
                    $expr =~ s{a\(n\-(\d+)\)}      {${esc}_$1}g;
                    if (0) {
                    } elsif ($order > 16) {
                        $nok = "order > 16";
                    } elsif ($expr =~ m{a|A\d+}   ) {
                        $nok = "remaining aA()";
                    } elsif ($expr !~ m{[\d\)n]\Z}) {
                        $nok = "wrong tail";
                    } elsif ($expr !~ m{${esc}_\d}) {
                        $nok = "no recurrence";
                    } else {
                        $expr = &zexpr($expr);
                    }
                } else {
                    $nok = "trailing words";
                }
                # with recurrence equation
            } else {
                $nok = "not a(n...) =";
            }
            if (length($nok) == 0) {
                #                      aseqno    callcode  offset   parm1   parm2    parm3   parm4  parm5
                print  join("\t",     $aseqno, $callcode, $offset, $order, $nshift, "xxxx", $expr, substr($name, 0, 64)) . "\n";
            } else {
                print STDERR join("\t", $aseqno, "?nok" , $offset, $order, $nshift, "$nok", $expr, $name) . "\n";
            }
        } # for all remembered names
        @names = ();
    } # offset line
} # while
#----
sub zexpr { # handle trailing mod and divisor
    my ($expr) = @_;
    my ($numer, $denom) = ("", "");
    if (0) {
    #                       1      1    23    3    2
    } elsif ($expr =~ m{\A\(([^\)]+)\)\/(.*)\Z}) { # cut of trailing divisor
        ($numer, $denom) = ($1, $2);
        $expr = &zsum($numer) . ".divide($denom)";
    #                       1      1    23    3    2
    } elsif ($expr =~ m{\A\(([^\)]+)\)\%(.*)\Z}) { # cut of trailing mod
        ($numer, $denom) = ($1, $2);
        $expr = &zsum($numer) . ".mod($denom)";
    } 
    $expr =~ s{\/(n|\d+)}{\.divide\($1\)}g; # simple divisor
    $expr =~ s{\%(n|\d+)}{\.mod\($1\)}g; # simple mod
    if ($expr =~ m{[\/\%]}) { # still with / %
        $nok = "interior / %";
    }
    return &zsum($expr);
} # zexpr
#----
sub zsum { # handle sum separated by "+" and "-"
    my ($expr) = @_;
    $expr =~ s{([\-])}{\+$1}g; # shield "-" = subtract
    my @parts = split(/\+/, $expr); # split on shield
    if (scalar(@parts) > 0 && ($parts[0] =~ m{\A([\-]?(\d+|n|\(\[n\d\+\-]+\)))})) { # first starts with simple
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
            $parts[$ipa] =  ".add<" . &zprod($part) . ">";
        } else {
            $parts[$ipa] = ">.add<" . &zprod($part) . ">";
        }
    } # for $ipa
    my $result = join("", @parts);
    # patches:
    $result =~ s{\.add\<[\-]}{\.sub\<}g;
    $result =~ s{\((\d+)\.pow\(n\)\)}{Z.valueOf\($1\)\.pow\(n\)}g;
    $result =~ s{\A\.sub}{Z\.ZERO\.sub};
    return $result;
} # zsum
#----
sub zprod { # handle product separated by "*", put non-Z factors at the 2nd position
    my ($expr) = @_;
    $expr =~ s({[\%\§])}{\*$1}g; # shield "%" = mod and "§" = xor
    my @parts = split(/\*/, $expr);
    if (scalar(@parts) > 0 && ($parts[0] =~ m{\A([\%\§]?(\d+|n|\(\[n\d\+\-]+\)))})) { # first starts with simple
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
            $parts[$ipa] =  ".mul[" . $part . "]";
        } else {
            $parts[$ipa] = "].mul[" . $part . "]";
        }
    } # for $ipa
    my $result = join("", @parts);
    # patches:
    $result =~ s{\.mul\[\%}{\.mod\(}g;
    $result =~ s{\.mul\[\§}{\.xor\(}g;
    $result =~ s{\(\.mul\[\-(\d+)\]\)}{\{-$1\}}g;
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


A133369	cordrec	0	1	1	xxxx	(3.multiply(a(n)).add(a(n-1)).multiply(2)).mod(37))	a(n+1) = (3*a(n) + 2*a(n-1))%37; a(1) = 1
081090	cordrec	1	2	0	xxxx	a(n-2).multiply((a(n-1).square()).add(1))	a(n) = a(n-2)*(a(n-1)^2 + 1)

