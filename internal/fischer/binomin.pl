#!perl

# Extract parameters for "a(n) = ... binomial(....)"
# 2021-05-07, Georg Fischer: copied from sumdiv.pl
#
#:# Usage:
#:#   perl binomin.pl [-d debug] [-s sel] $(COMMON)/jcat25.txt > binomin.gen 
#:#     -d debugging level (0=none (default), 1=some, 2=more)
#:#     -s selection: 0 = all, 1 = some, 2 = specific ... 
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $sel = 0;
my $line = "";
my ($tlet, $aseqno, $callcode, $name, $form);
my $debug   = 0;
while (scalar(@ARGV) > 0 && ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } elsif ($opt   =~ m{\-s}  ) {
        $sel        = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $offset  = 0;
my $oseqno  = "A000000"; # old aseqno
my $count   = 0;
my %shields = qw(
   binomial        nnnn1
   doublefactorial nnnn2
   factorial       nnnn3
   GAMMA           nnnn4
   pochhammer      nnnn5
   );

while (<>) { # from $(COMMON)/jcat25.txt
    s/\s+\Z//; # chompr
    $line = $_;
    ($tlet, $aseqno, $name) = (substr($line, 1, 1), substr($line, 3, 7), substr($line, 11));
    foreach my $key (sort(keys(%shields))) {
    	$name =~ s{$key}{$shields{$key}}ig; # shield only these functions
    } # foreach $key
    if ($aseqno ne $oseqno) {
        $oseqno = $aseqno;
        $count = 1;
    } else {
        $count ++;
    }
    $callcode = "binom";
    $form = "";
    $offset = 0;
    # print "p0: $sel $tlet [$name]\n";
    split_offset($name);
    # print "p1: $sel $tlet [$name]\n";
    if (substr($name, 0, 1) eq " ") {
        # ignore if indented
        # print "pi: $sel $tlet [$name] ignored\n";
    } elsif ($sel >= 2 && $tlet eq "N" && ($name !~ m{\.\.})) { # NAME
        if ($name =~ m{\A(a\(n\)\s*\=\s*)?([^\.]+)}) {
            $form = &eval_form($2);
        }
    } elsif ($sel >= 2 && $tlet eq "F" && ($name !~ m{\.\.})) { # FORMULA
        if ($name =~ m{\Aa\(n\)\s*\=\s*([^\.]+)\.}) {
            $form = $1;
            $form = &eval_form($form);
        }
    } elsif ($sel >= 0 && $tlet eq "p") {
        # print "p2: $sel $tlet [$name]\n";
        $name =~ s{\#.*}{};     # remove trailing comment
        # $name =~ s{\A(\d+\, *)+seq\(}{seq\(}; # 1,2,seq( -> seq(
        $name =~ s{ *\; *\Z}{}; # remove semicolon
        if ($name =~ m{\Aseq\((.*)\Z}) {
            $form = $1;
            $form =~ s{\)\Z}{};
            if ($form !~ m{\, *n\=\d+\.\.\w+\)\,}) {
                $form =~ s{\, *n\=\d+\.\.\w+}{};
                $form = &eval_form($form);
            } else {
                print STDERR join("\t", $aseqno, "$callcode$count", $offset, $form, $tlet) . "\n"; 
                $form = "";
            }
        } else {
            #   print "#%p name? " . join("\t", $aseqno, "$callcode$count", $offset, $form, $name) . "\n"; 
        }
    } elsif ($sel >= 2 && $tlet eq "t") { # Mathematica
        $name =~ s{ *\(\*.*}{}; # remove trailing comment
        $name =~ s{\AJoin\[ *\{\d+(\, *\d+)*\}\, *(.*)\]\Z}{$2}; # remove Join[{1,2},...] (initial terms)
        $name =~ s{Range\[[^\]]+\]}{n}g; # replace Range[...] by n
        # print "t2: $sel $tlet [$name]\n";
        if ($name =~ m{\ATable\[(.*)\]\Z}) {
            # print "t3: $sel $tlet [$name]\n";
            $form = lc($1);
            if ($form !~ m{\}\, *\{}) {
                $form =~ s{\, *\{n\, *\d+\, *\w+\}}{};
                # print "t4: $sel $tlet \"$form\"\n";
                $form = &eval_form($form);
                # print "t5: $sel $tlet \"$form\"\n";
            } else {
                print STDERR join("\t", $aseqno, "$callcode$count", $offset, $form, $tlet) . "\n"; 
                $form = "";
            }
        } else {
        }
    } elsif ($sel >= 2 && $tlet eq "o" && ($name =~ s{\(PARI\) *}{})) {
        $name =~ s{\\\\.*}{};   # remove trailing comment
        $name =~ s{ *\; *\Z}{}; # remove semicolon
        $name =~ s{\{(.*)\}\Z}{$1}; # remove outer { }
        if ($name =~ m{\Aa\(n\)\s*\=\s*([^\.]+)}) {
            $form = $1;
            $form =~ s{[\{\}]}{}g; # remove { } 
            if ($form !~ m{[\%\\\=\<\>\~\[\]\|]}) {
                $form = &eval_form($form);
            } else {
                print STDERR join("\t", $aseqno, "$callcode$count", $offset, $form, $tlet) . "\n"; 
                $form = "";
            }
        }
    }
    $form =~ s{\A[ \.\,\:\;]+}{};
    $form =~ s{[ \.\,\:\;]+\Z}{};
    if ($form ne "") {
        print join("\t", $aseqno, "$callcode$count", $offset, $form, $tlet) . "\n"; 
    } else {
    }
} # while <>
#--------
sub split_offset { # modifies $offset, $name
    $offset = 0;
    if ($name =~ s{(for|if|when|with|\,) *n *(\>\=?) *(\d+)}{}) {
        my ($cond, $lim) = ($2, $3);
        if ($cond !~ m{\=}) {
            $lim ++;
        }
        $offset = ($offset < $lim) ? $lim : $offset;
    }
    while ($name =~ s{a\((\d+)\) *\= *\d+ *[\,\;\.]}{}) {
        my $lim = $1 + 1; # not member of the recurrence
        $offset = ($offset < $lim) ? $lim : $offset;
    } # while
    $name =~ s{\A[ \.\,\:\;]+}{};
    $name =~ s{[ \.\,\:\;]+\Z}{};
} # split_offset
#--------
sub eval_form {
    my ($result) = @_;
    $result =~  s{\s}{}g; # remove whitespace
    if (&is_balanced($result) && ($result =~ m{\A[n0-9\+\-\(\)\*\/\!\^\,]+\Z})) { # is an expression in n with + - * / ^ ! ( ) digits && nnnn( , )
        # print "t6: $sel $tlet \"$result\"\n";
        # now repair lazy bracketing
        $result =~  s{(\d+)n}{$1*n}g; # 2n -> 2*n
        $result =~  s{\^(\w)\^(.*)}{\^\($1\^$2\)}; # ...^2^... -> ...^(2^...)
        foreach my $key (sort(keys(%shields))) {
            $result =~ s{$shields{$key}}{$key}ig; # shield only these functions
        } # foreach $key
        $result =~  s{\)(\w)}{\)\*$1}g;  # )n -> )*n
        $result =~  s{\!(\w)}{\!\*$1}g;  # !n -> !*n
        $result =~  s{\!\(}{\!\*\(}g;    # !( -> !*(
        $result =~  s{nn}{n\*n}g;        # nn -> n*n
        $result =~  s{n(\d+)}{n\*$1}g;   # n3 -> n*3
        $result =~  s{(\d+)n}{$1\*n}g;   # 3n -> 3*n
        $result =~  s{(\d+)\(}{$1\*\(}g; # 3( -> 3*(
        $result =~  s{\)\(}{\)\*\(}g;    # )( -> )*(
        $result =~  s{binomial\*}{binomial}g;
        if ( ($result =~ m{\A\!}) 
          or ($result =~ m{\!\!|\*\!|\w\^\w\^})
          ) {
            # print "t7: $sel $tlet \"$result\"\n";
            $result = "";
        }
    } else {
        $result = "";
    }
    return $result;
} # eval_form
#--------
# from https://www.perlmonks.org/?node_id=885625

sub is_balanced {
    my( $str )= @_;
    my $d= 0;
    while(  $str =~ m(([(])|([)]))g  ) {
        if(  $1  ) {
            $d++;
        } elsif(  --$d < 0  ) {
            return 0;
        }
    }
    return 0 == $d;
}
#--
sub is_balanced3 { eval "qw($_[0])" }
#--
sub is_balanced2 {
   my $string = shift;
   eval("qw($string)");
   return 0 if $@;
   return 1;
}

__DATA__
012345678901
%p A061164         binomial(20*n,10*n)*binomial(10*n,3*n)/binomial(4*n,n) ;
%t A061200 tau[1, k_] := 1; tau[n_, k_] := Times @@ (Binomial[Last[#]+k-1, k-1]& /@ FactorInteger[n]); Table[tau[n, 5], {n, 1, 100}] (* _Amiram Eldar_, Sep 1
%F A061206 a(n) = n!*binomial(-n,4). - _Peter Luschny_, Apr 29 2016
%p A061206 a := n -> n!*binomial(-n,4): seq(a(n),n=1..20); # _Peter Luschny_, Apr 29 2016
%t A061206 Array[# (# + 3)!/24 &, 20] (* or *) Array[#!*Binomial[-#, 4] &, 20] (* _Michael De Vlieger_, Sep 30 2017 *)
%o A061206 (Sage) [binomial(n,4)*factorial (n-3) fo r n in range(4, 21)] # _Zerinvary Lajos_, Jul 07 2009
%o A061312 (MAGMA) [[(&+[(-1)^j*Binomial(k+1,j)*Factorial(n-j+1): j in [0..k+1]]): k in [0..n]]: n in [0..20]]; // _G. C. Greubel_, Aug 13 2018
%F A061548 a(n) = numerator(binomial(2*n-1/2, -1/2)).
%p A061548 seq(numer(binomial(2*n-1/2, -1/2)), n=0..20);
%F A061549 a(n) = denominator of binomial(2*n-1/2, -1/2).
%p A061549 seq(denom(binomial(2*n-1/2, -1/2)), n=0..20);
%p A061718 a:=n->mul(binomial(n+2,2), k=0..n): seq(a(n), n=0..12); # _Zerinvary Lajos_, Oct 02 2007
%N A061834 a(n) = binomial(n,2) * !n.
%o A061834 (PARI) { f=1; L=0; for (n=0, 200, if (n, L+=f; f*=n); write("b061834.txt", n, " ", L*binomial(n, 2)) ) } \\ _Harry J. Smith_, Jul 28 2009
%F A062141 a(n) = (n+2)!*binomial(n+5, 5)/2!.
%p A062141 a:= n->(n+2)!*binomial(n+5, 5)/2!: seq(a(n), n=0..20); # _Zerinvary Lajos_, Apr 29 2007
%t A062141 Table[(n+2)!*Binomial[n+5,5]/2!,{n,0,15}] (* _Indranil Ghosh_, Feb 24 2017 *)
%o A062141 (Sage) [binomial(n,5)*factorial (n-3)/2 for n in range(5, 21)] # _Zerinvary Lajos_, Jul 07 2009
%o A062141 (PARI) a(n)=(n+2)!*binomial(n+5,5)/2! \\ _Indranil Ghosh_, Feb 24 2017
%o A062141 (MAGMA) [Factorial(n+2)*Binomial(n+5,5)/2: n in [0..20]]; // _G. C. Greubel_, May 11 2018
%F A062142 a(n) = (n+3)!*binomial(n+6, 6)/3!; e.g.f.: (1+18*x+45*x^2+20*x^3)/(1-x)^10.
%t A062142 Table[(n+3)!*Binomial[n+6,6]/3!,{n,0,15}] (* _Indranil Ghosh_, Feb 23 2017 *)
%o A062142 (Sage) [binomial(n,6)*factorial(n-3)/factorial(3) for n in range(6, 22)] # _Zerinvary Lajos_, Jul 07 2009
%o A062142 (PARI) a(n) =(n+3)!*binomial(n+6,6)/3! \\ _Indranil Ghosh_, Feb 23 2017
%o A062142 (MAGMA) [Factorial(n+3)*Binomial(n+6,6)/6: n in [0..20]]; // _G. C. Greubel_, May 12 2018
%F A062143 a(n) = (n+4)!*binomial(n+7, 7)/4!;
%t A062143 Table[(n+4)!*Binomial[n+7,7]/4!,{n,0,15}] (* _Indranil Ghosh_, Feb 23 2017 *)