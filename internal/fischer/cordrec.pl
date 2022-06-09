#!perl

# Grep (Somos-like) recurrences from jcat25.txt
# @(#) $Id$
# 2022-06-07: most of the code now exported to cordrec_prep.pl
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
my $withA = 1;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug      = shift(@ARGV);
    } elsif ($opt  =~ m{A}) {
        $withA      = 0;
    }
} # while $opt

my $esc = "b";
my $Esc = "B";
my $callcode = "cordrec";
my $nok = "";
my $offset = 0;
my $aseqno = "";
my $name   = "";
my $inits;
my $expr;
my $nshift;
my $order;

while (<>) {
    my $line = $_;
    $line =~ s/\s+\Z//; # chompr
    $nok = "";
    if ($line !~ m{\AA\d+}) { # comment line
        print "$line\n";
    } else { # seq4 record
        ($aseqno, $callcode, $offset, $order, $nshift, $inits, $expr, $name) = split(/\t/, $line);
        if (0) {
        } else {
            $expr = &unshield($expr);
            if (length($expr) > 1024) {
                $nok = "length  > 1024";
            }
            if (($expr =~ m{mA\d+}) && $withA == 0) {
                $nok = "skip A-number";
            }
        }
        if (length($nok) == 0) {
            #                      aseqno    callcode  offset   parm1   parm2    parm3   parm4  parm5
            print  join("\t",     $aseqno, $callcode, $offset, $order, $nshift, $inits, $expr, $name) . "\n";
        } else {
            print STDERR join("\t", $aseqno, "$nok" , $offset, $order, $nshift, $inits, $expr, $name) . "\n";
        }
    } # seq4 record
} # while
#----
sub unshield {
    my ($expr) = @_;
#   $expr =~ tr{\<\>\{\}\[\]\~\#\µ\°}
#              {\(\)\(\)\(\)\-\+\/\*}; # unshield brackets and + - * /
    $expr =~ tr{\<\>\{\}\[\]\~\#}
               {\(\)\(\)\(\)\-\+}; # unshield brackets and + - * /
    $expr =~ s{\°}{\*}g;
    $expr =~ s{\µ}{\/}g;
    $expr =~ s{\.mul\(}             {\.multiply\(}g;
#   $expr =~ s{\.add\(}             {\.add\(}g;
    $expr =~ s{\.sub\(}             {\.subtract\(}g;
    $expr =~ s{\A\-(${esc}__?\d+)}  {$1\.negate\(\)};
    $expr =~ s{\A\-(\d+)}           {Z\.valueOf\(\-$1\)};
    $expr =~ s{\A\(\-([n\d]+)}         {\(Z\.valueOf\(\-$1\)};
    $expr =~ s{\A\(([n\d]+)}        {\(Z\.valueOf\($1};
    $expr =~ s{\(\(([n\d]+)}        {\(Z\.valueOf\($1};
    $expr =~ s{${Esc}(\d+)_0}       {mA$1m0}g;
    $expr =~ s{${Esc}(\d+)__(\d+)}  {mA$1p$2}g;
    $expr =~ s{${Esc}(\d+)_(\d+)}   {mA$1m$2}g;
    $expr =~ s{${esc}_0}            {a\(n\)}g;
    $expr =~ s{${esc}__(\d+)}       {a\(n\+$1\)}g;
    $expr =~ s{${esc}_(\d+)}        {a\(n\-$1\)}g;
    # patches:
    #            1            1
    $expr =~ s{\((\([^\(\)]+\))\)}                  {$1}g;
    $expr =~ s{\.mod\((\d+|n)\)}                    {\.mod\(Z.valueOf\($1\)\)}g;
    $expr =~ s{\.xor\((\d+|n)\)}                    {\.xor\(Z.valueOf\($1\)\)}g;
    $expr =~ s{\.add\(Z\.valueOf\((\d+|n)\)\)}      {\.add\($1\)}g;
    $expr =~ s{\((\d+|n)\.}                         {\(Z\.valueOf\($1\)\.}g;
    return $expr;
} # unshield
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

