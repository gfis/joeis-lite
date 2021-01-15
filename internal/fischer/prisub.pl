#!perl

# Extract parameters for PrimeSubsequence from names like "Numbers such that ... is prime"
# 2021-01-12, Georg Fischer: copied from suchprim.pl
#
#:# Usage:
#:#   grep ... $(COMMON)/joeis_names.txt \
#:#   | perl prisub.pl [-d debug] [-e] [-f ofter_file] > output
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#:#     -e  exclude most patterns
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
my $ex = "";
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } elsif ($opt   =~ m{\-e}  ) {
        $ex         = "xx";
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

my ($parms, $letter, $expr);
while (<>) { # from joeis_names.txt
    s/\s+\Z//; # chompr
    $line = $_;
    $line =~ s{\, where .*|\(where .*}{};
    $line =~ s{ is (a )?prime( number)?}{\; is prime};
    $line =~ s{ for which }{ such that };
    $parms = "";
    $expr  = ""; 
    ($aseqno, $superclass, $name, @rest) = split(/\t/, $line);
#   if (defined($ofters{$aseqno}) and ($superclass !~ m{A099192|A102915|A103603|BriefSequence|FiniteSequence|PowerFactorPrimeSequence})) {
    if (defined($ofters{$aseqno}) and ($superclass !~ m{BriefSequence|ComplementSequence|FiniteSequence|PowerFactorPrimeSequence})) {
        print STDERR "# $aseqno $superclass - ignore since already implemented\n";
        $expr = "";
    } elsif ($name =~ m{ers ([a-z]) such that (the string |the concatenation )?([^\;]+)\; is prime *(\Z|\.)}) {
        $letter = $1;
        $expr   = $3;
        $expr   =~ s{$letter}{k}g;
        $callcode = "prisub";
        &varcount();
    } elsif ($name =~ m{Primes of (the )?form (.*)}) {
        $expr   = $2;
        $callcode = "primof";
        $expr =~ s{[\.\,\{\(\;\:].*}{};
        &varcount();
    } elsif ($name =~ m{\Aa\([i-n]\) *\= *(.*)}) {
        $expr   = $1;
        $callcode = "anumof";
        $expr =~ s{[\.\,\{\(\;\:].*}{};
        &varcount();
    } else {
        print STDERR "$line\n";
    } # if proper name
    if (length($parms) > 0) {
        print join("\t", $aseqno, $callcode, $parms, $superclass) . "\n";
    } else {
        print STDERR join("\t", $aseqno, $expr, $name) . "\n";
    }
} # while <>
#----
sub varcount { # count the number of single letters in the formula
    $expr =~ s{ }{}g;
    my %hash = ();
    foreach my $letter ($expr =~ m{([a-z])}g) {
        if ($letter !~ m{[ijklmn]}) {
            $hash{"0"} = 1; # ensures that there will be >=2 hash members
        }
        $hash{$letter} = 1;
    } # foreach $letter
    my $result = scalar(%hash);
    if ($result <= 1) {
        foreach $letter (keys(%hash)) { # there is only one
            $expr =~ s{$letter}{k}g;
        }
        $parms = &parse();
    } else {
        print STDERR "# $aseqno scalar(hash) >= 2: \"" . join(",", keys(%hash)) . "\", expr=$expr\n";
    } 
    return $result;
} # varcount
#----
sub parse { # parse the formula, and generate a holonomic recurrence if possible
    $expr =~ s{(\A|[\+\-])k}{${1}1\*k}g;      # +k    -> +1*k
    $expr =~ s{(\d)k}{${1}\*k}g;              # 1234k -> 1234*k
    $expr =~ s{(\d+)\^(\d+)}{$1**$2}eg;       # 2^10  -> 1024
    $expr =~ s{k\!\[(\d+)\]}{k\!$1}g;         # k![3] -> k!3
    $expr =~ s{k(\!+)(\D)}{"k\!" . length($1) . $2}eg; # k!!!  -> k!3
    $expr =~ s{\AR_k}{1*R_k};                 # R_k -> 1*R_k
    my $result = "";
    my ($p1, $p2, $p3, $p4, $p5, $p6, $p7, $p8, $p9);
    if ($expr =~ m{[a-z][a-z]}) {
        # ignore if there is a word

    } elsif ($expr =~ m{\A$ex(\d+)\*k([\+\-])(\d+)\Z}) { # 7*k~7
        (                    $p1,    $p2,    $p3     ) = ($1, $2, $3);
        $result  = join("\t", 1, "[[$p1],[1],[-1]]"                                , "[$p2$p3]",                  0, "", "", $expr);

    } elsif ($expr =~ m{\A$ex(\d+)\^k([\+\-])(\d+)\Z}) { # 7^k~7
        (                    $p1,    $p2,    $p3) = ($1, $2, $3);
        $result  = join("\t", 1, "[[" . eval("-($p2$p3)*($p1-1)") . "],[$p1],[-1]]", "[" . eval("1$p2$p3") . "]", 0, "", "", $expr);

    } elsif ($expr =~ m{\A$ex(\d+)\*k\^(\d+)([\+\-])(\d+)\Z}) { # 7*k^7~7; a(n) = 23*k^2 + 5 -> "[[5,0,23],[-1]]","[23+5]"
        (                    $p1,      $p2, $p3,    $p4) = ($1, $2, $3, $4);
      if ($p2 <= 6) {
        $result  = join("\t", 1, "[[$p3$p4" . (",0" x ($p2 - 1)) . ",$p1],[-1]]",    "[" . eval("$p3$p4") . "]",  0, "", "", $expr);
      } else {
        $result = "";
      }

    } elsif ($expr =~ m{\A$ex(\d+)([\+\-]\d+)\*k(([\+\-](\.\.\.[\+\-])?\d+\*k\^\d+)+)\Z}) { # 7~7*k~7*k^7~7*k^7
        (                    $p1, $p2,          $p3                                 ) = ($1, $2, $3, $4);
        # 32 pass, very good
        $result  = join("\t", 1, "[[$p1,$p2");
        my $iexp = 1;
        my @pairs = ($p3 =~ m{([\+\-](\.\.\.[\+\-])?\d+\*k\^\d+)}g);
        my ($oldfactor, $oldexp) = (1,1);
        foreach my $pair (@pairs) {
            if ($pair =~ m{([\+\-]\d+)\*k\^(\d+)}) {
                my ($factor, $exp) = ($1, $2);
                if ($pair =~ m{\.\.\.}) { # with ellipsis
                    while ($iexp + 1 < $exp) {
                        $result .= "," . (($iexp + 1) & 1);
                        $iexp ++;
                    } # while $iexp
                    $result .= ",1";
                    # with ellipsis
                } else {
                    while ($iexp + 1 < $exp) {
                        $result .= ",0";
                        $iexp ++;
                    } # while $iexp
                    $result .= ",$factor";
                }
                # print "# pair=$pair, factor=$factor, exp=$exp\n";
                $iexp ++;
                ($oldfactor, $oldexp) = ($factor, $exp);
            }
        } # foreach
        $result .=  join("\t", "],[-1]]", "[$p1]",  0, "", "", $expr);

    } elsif ($expr =~ m{\A(\d+)\*k\!(\d+)?([\+\-]\d+)\Z}) { # 7*k!7~7;
        (                 $p1,      $p2,  $p3) = ($1, $2 || 1, $3);
        # k!6-1 -> "[[-1],[0,1],[0],[0],[0],[0],[0],[-1]]", [1,1,2,3,4,5]-1 ; GU=8, very good
        $p3 =~ s{\+}{};
        print "# p1=$p1, p2=$p2, p3=$p3, expr=$expr, name=$name\n";
        my @inits = ($p1);
        for (my $ind = 1; $ind < $p2; $ind ++) {
            push(@inits, $p1*$ind);
        } # for
        $callcode .= "f";
        $result  = join("\t", 1, "[[0],[0,1]" . (",[0]" x ($p2 - 1)) . ",[-1]]", join(",", @inits), 0, $p3, "", $expr);

    } elsif ($expr =~ m{\A$ex([\+\-]?\d+(\*k(\^\d+)?)?)([\+\-](\d+(\*k(\^\d+)?)?))*\Z}) { # sum_{i} +-k^i
        my %hash = ();
        my $maxexp = 0;
        my $sign = "+";
        my ($factor, $exp);
        foreach my $part (split(/([\+\-])/, $expr)) {
            if ($part eq "") { # at the beginning - ignore
            } elsif ($part =~m{\A[\+\-]\Z}) {
                $sign = $part;
            } else {
                if ($part !~ m{k}) {
                    $part .= "*k^0";
                }
                if ($part =~ m{k\Z}) {
                    $part .= "^1";
                }
                $part =~ m{(\d+)\*k\^(\d+)};
                ($factor, $exp) = ($1, $2);
                if (! defined($factor) or ! defined($factor) or ! defined($factor)) {
                    print "# undefined? factor=$factor, exp=$exp, part=$part, expr=$expr\n";
                    $factor = 1;
                    $exp    = 0;
                }
                $factor = "$sign$factor";
                $hash{$exp} = $factor; # exponent mapped to factor
                if ($exp > $maxexp) {
                    $maxexp = $exp;
                }
            }
            # print "# parse: part=$part, expr=$expr, sign=$sign, factor=$factor, exp=$exp\n";
        } # foreach
        if ($maxexp <= 128) {
            my @list = ();
            for (my $iexp = 0; $iexp <= $maxexp; $iexp ++) {
                push(@list, 0);
            }
            foreach my $key (keys(%hash)) {
                $list[$key] = $hash{$key};
            }
            $result  = join("\t", 1, "[[" . join(",", @list) . "],[-1]]", "[$list[0]]", 0, "", "", $expr);
        } else {
            $result = "";
        }

    #     82 (7^k~7)/7
    } elsif ($expr =~ m{\A$ex\((\d+)\^k([\+\-]\d+)\)\/(\d+)\Z}) {
        my (                   $b,     $c,            $d) = ($1, $2, $3);
        # a(n) = (b^n+c)
        # c-b*c + b*a(n-1) - a(n)=0
        # MATRIX="[[c-b*c],[b],[-1]]" INIT="[1+c,b+c]"
        # The divisor $d is evaluated in prisub.jpat.
        
        $callcode .= "d";
        $result  = join("\t", 1, "[[".($c-$b*$c)."],[".($b)."],[-1]]"
            , "[".(1+$c).",".($b+$c)."]", 0, "$d", "", $expr);

    #    100 (7^k~7^k)/7; A228076 (19^k-4^k)/15 -> MATRIX="[[0],[-76]=-|-4|*|19|,[23=|-4|*|19|],[-1]" INIT="[0,19-4]"
    } elsif ($expr =~ m{\A$ex\((\d+)\^k([\+\-])(\d+)\^k\)\/(\d+)\Z}) {
        (                      $p1,    $p2    ,$p3         ,$p4) = ($1, $2, $3, $4);
        $callcode .= "d";
        $result  = join("\t", 1, "[[0],[".(-$p1*$p3)."],[".($p1+$p3)."],[-1]]"
            , "[".eval("1${p2}1").",".eval("$p1$p2$p3")."]", 0, "$p4", "", $expr);

    #    A062600 Numbers n such that 34^n - 33^n is prime. -> lin.rec. {34+33, -34*33}
    } elsif ($expr =~ m{\A$ex(\d+)\^k([\+\-])(\d+)\^k\Z}) {
        (                      $p1,    $p2    ,$p3      ) = ($1, $2, $3);
        $result  = join("\t", 1, "[[0],[".(-$p1*$p3)."],[".($p1+$p3)."],[-1]]"
            , "[".eval("1${p2}1").",".eval("$p1$p2$p3")."]", 0, "", "", $expr);

    #    135 7*7^k~7*(7^k~7)/7~7
    #     58 7*(7^k~7)/7~7
    
    } elsif ($expr =~ m{\A$ex(A\d+)[\(\[]k[\)\]]\Z}) { # A123456(k) -> see prisub.sql
        my $rseqno = $1;
        if (defined($ofters{$rseqno})) {
            $callcode .= "a";
            $result= join("\t", 1, $rseqno, "", 0, "", "", $expr);
        }

    } elsif ($expr =~ m{\A$ex(A\d+)[\(\[]k[\)\]]([\+\-]\d+)\Z}) { # A123456(k) + 17
        my $rseqno = $1;
        my $const  = $2;
        if (defined($ofters{$rseqno})) {
            $callcode .= "c";
            $result= join("\t", 1, $rseqno, $const, 0, "", "", $expr);
        }

    # A056657 60*R_k+7
    } elsif ($expr =~ m{\A$ex(\d)0\*R_k\+(\d+)\Z}) {
        (                    $p1,      $p2       ) = ($1, $2);
        $result  = join("\t", 1, "[[".eval("-10*$p2+10*$p1+$p2")."],[10],[-1]]", "[$p2,".eval("10*$p1+$p2")."]", 0, "", "", $expr);

    # A099409 2*R_k+5 Numbers n such that 2*R_n + 5; is prime
    } elsif ($expr =~ m{\A$ex(\d)\*R_k([\+\-]\d+)\Z}) { # 46 pass GU=4
        (                 $p1,     $p2       ) = ($1, $2); # parentheses around $p2 since sign is included!
        $result  = join("\t", 1, "[[".eval("-10*($p2)+$p1+($p2)"   )."],[10],[-1]]", "[$p2,".eval("$p1$p2")    ."]", 0, "", "", $expr);

    # A103109 9*10^k+8*R_k-1  Numbers n such that 9*10^n + 8*R_n - 1; is prime
    # A259050 3*R_k+10^k-2    Numbers k such that 3*R_k + 10^k - 2; is prime
    # A056698 10^k+3*R_k
    } elsif (($expr =~ m{R_k$ex}) and ($expr =~ m{10\^k})) {
        my $aconst = "+0";
        my $factRk = "+1";
        my $fact10 = "+1";
        my $sign  = "+";
        foreach my $part (split(/([\+\-])/, $expr)) {
            # print "# parse: part=$part, expr=$expr\n";
            if ($part =~m {\A[\+\-]\Z}) {
                $sign = $part;
            } elsif ($part =~ m{\A(\d+\*)?R_k\Z}) {
                $factRk = "$sign" . ($1 || "1");
                $factRk =~ s{\*\Z}{};
            } elsif ($part =~ m{\A(\d+\*)?10\^k\Z}) {
                $fact10 = "$sign" . ($1 || "1");
                $fact10 =~ s{\*\Z}{};
            } elsif ($part =~ m{\A(\d+)\Z}) {
                $aconst = "$sign$1";
            } else {
                print "# unknown part=$part, aseqno=$aseqno, expr=$expr\n";
            }
        } # foreach
        print "# aseqno=$aseqno, expr=$expr, fact10=$fact10, factRk=$factRk, aconst=$aconst\n";
        $result  = join("\t", 1, "[[".eval("-10*($aconst)$factRk+($aconst)")."],[10],[-1]]"
            , "[".eval("$fact10$aconst").",".eval("$fact10*10$factRk$aconst")."]", 0, "", "", $expr);

    } elsif (0) {

    }
    $result =~ s{([\[\,])\+}{$1}g; # [+7 -> [7
    return $result;
} # parse
#================
__DATA__
        # a(n) = (4^n+11)/3
        # a(n-1) = (4^(n-1)+11)/3
        # 3*a(n) = 4^n+11 = 4*4^(n-1)+11
        # 3*a(n-1)-11 = 4^(n-1)
        # -3*a(n)+4*(3*a(n-1)-11)+11=0
        # 11+12*a(n-1)-44-3*a(n)=0
        # -33+12*a(n-1)-3*a(n)=0
        #
        # a(n) = (b^n+c)/d
        # a(n-1) = (b^(n-1)+c)/d
        # d*a(n) = b^n+c = b*b^(n-1)+c
        # d*a(n-1)-c = b^(n-1)
        # -d*a(n)+b*(d*a(n-1)-c)+c=0
        # c-b*c + b*d*a(n-1) - d*a(n)=0
        # MATRIX="[[c-b*c],[b*d],[-d]]" INIT="[(c+1)/d]"
        # But many of these sequences have potential terms that are fractions. 
        # Only odd indices yield primes in these cases.

    # A103109 9*10^k+8*R_k-1  Numbers n such that 9*10^n + 8*R_n - 1; is prime
a(k)=t*10^k+r*R_k+c
0=t*10^k+r*R_k+c-a(k)

"0 = t*10^(k-1) + r*R_(k-1) + c - a(k-1)
"
