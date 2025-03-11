#!perl

# wpartsum.pl
# Generate for Wesley's sequences "Number of partitions ..." realized with nested sums
# 2025-03-11, Georg Fischer
use strict;
use warnings;
use integer;

my $debug   = 0;
my $expand  = 1;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     =  shift(@ARGV);
    } elsif ($opt  =~ m{x}) {
        $expand    = 0;
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
#----------------
my $letters = "ijklmopqrstuvwxyz"; # n is missing!
#          0        1                                  2 3 4 5 6 7 8 9 10
my @nsu = ("dummy", quotemeta("Sum_{i=1..floor(n/2)}"),0,0,0,0,0,0,0,0,0);
my @jsu = ("dummy",           "Sum_{i=1..floor(n/2)}" ,0,0,0,0,0,0,0,0,0);
for (my $nsum = 2; $nsum <= 10; $nsum ++) {
  my $joeis = "";
  my $noeis = "";
  for (my $irsum = 0; $irsum < $nsum; $irsum ++) {
    my ($i, $j) = split(/=/,        &lowix($nsum, $irsum));
    $joeis = "SU($j, "            . &uppix($nsum, $irsum) . ", $i -> " . $joeis;
    $noeis = "Sum_{$i=$j..floor(" . &uppix($nsum, $irsum) . ")} "      . $noeis;
  } # for irsum
  $nsu[$nsum] = quotemeta($noeis);
  $jsu[$nsum] =          ($joeis); 
  if ($debug >= 1) {
    print STDERR "# jOEIS[$nsum]: $jsu[$nsum]\n";
    print STDERR "#  OEIS[$nsum]: $nsu[$nsum]\n";
  }
} # for nsum
# exit(0);

my %corr_hash;
&corrections;

my $nsum;
while (<>) {
    s/\s+\Z//; # chompr 
    #  1           1
    s{^([\#\%][NFC]) }{}; # remove any type 
    my $type = $1;
    my $line = $_;
    #                                  aseqno cc      p0 parm1 parm2   parm3    parm4    parm5
    my ($aseqno, $callcode, @parms) = ("",    "#nyi", 0, "sx", "form", "funct", "withN", "??");
    my ($sx, $funct, $withN) = ("SX?", "", "");
    #                1    1              2  2
    if ($line =~ m{\A(A\d+) *a\(n\) *\= *(.*)}) {
      $aseqno = $1;
      $line = $2;
    }

    # polish the input
    $line =~ s{\(n\-1\)\/4}{(n-l)/4}g; # correction!
    $line =~ s{\(n\-k\-l\-m\-o\)\/3\}}{(n-k-l-m-o)/3)\}}g; # correction!
    if ($aseqno eq "A308975") {
      $line =~ s{o\) *o}{o\) \* o}; # correction!
    }
    $line =~ s{\. *\(End\) *}{};

    if ($line =~ m{\/(\d+)}) { # first number - 1 yields the number of nested sums
      $nsum = $1 - 1;
    }
    if ($line =~ s{$nsu[$nsum]}{\(}) {
      $callcode = "wpartsum";
      $sx = "SX_$nsum";
      if ($line =~ s{\A *n *\* *}{}) {
        $withN = ".multiply(n)";
      }
    }

    # , where [ ] is the Iverson bracket
    if ($line =~ s{\, where \[ *\] is the .*}{}) {  # and [ ] is the (generalized) Iverson bracket
      #                  [1      1 ]
      while ($line =~ m{\[([^\]]+)\]}) {
        my $bracket = $1;
        # print STDERR "# bracket1=\"$bracket\"\n";
        #             1      1  2     2
        $bracket =~ s{ \= }{ == }g;
        # print STDERR "# bracket2=\"$bracket\"\n";
        $line =~ s{\[([^\]]+)\]}{($bracket \? 1 \: 0\)};
      }
    }

    if ($line =~ s{\, where omega.*}{}) {
      $line =~   s{omega\(([^\)]+)\)}   {eval1\($1\)}g; 
      $funct =    "f0001221";
    }
    if ($line =~ s{\, where mu.*}{}) {
      $line =~   s{mu\(([^\)]+)\)\^2}   {eval1\($1\)}g; # MU().abs()
      $funct =    "f008966";
    }
    #                 1      1 2             3     3                             2
    if ($line =~ s{\, (where )?(c = A010051|c(\(n\))? is the prime characteristic).*}{}) {
      $line =~ s{c\(([^\)]+)\)}         {eval1\($1\)}g;
      $funct =    "f010051";
    }
    if ($line =~ m{A010051\(}) {
      $line =~   s{A010051\(([^\)]+)\)} {eval1\($1\)}g;
      $funct =    "f010051";
    }

    #                 1      1 2             3     3     2
    if ($line =~ s{\, (where )?(c = A010052|c(\(n\))? is ).*}{}) {
      $line =~ s{c\(([^\)]+)\)}         {eval1\($1\)}g; # SQUARE.is
      $funct =    "f010052";
    }
    if ($line =~ m{A010052\(}) {
      $line =~   s{A010052\(([^\)]+)\)} {eval1\($1\)}g;
      $funct =    "f010052";
    }

    # , where c(n) = 1 - ceiling(n) + floor(n)
    #                       1 2  2 1
    if ($line =~ s{\, where (c(hi)?)\(n\) (is|\=) 1 \- ceiling.*}{ }) { # add a space for match below
      my $repl = $1;
      #                 1     2     2 1
      while ($line =~ m{($repl(\(\S+) )}) {
        my $chi  = quotemeta($1);
        my $parm = $2;
        $parm =~ s{\/}{\,};
        $line =~ s{$chi}                {eval2$parm };
        # print STDERR "chi=$chi, parm=$parm, line=$line\n";
      }
      $funct =    "f1chi";
    }
    # (1 - ceiling(n/(n-i-j)) + floor(n/(n-i-j))
    #                                   1   1
    while ($line =~ m{\(1 *\- *ceiling\((\S+) *\+ *floor\(\1\)}) {
      my $evparm = $1;
      $evparm =~ s{\/}{\,};
      my $s =
      $line =~      s{\(1 *\- *ceiling\((\S+) *\+ *floor\(\1\)}{eval2\($evparm};
      if ($debug >= 1) {
        print STDERR "# $aseqno: standalone f1chi, evparm=\"$evparm\", s=$s, line=$line\n";
      }
      $funct =    "f1chi";
    }

    # , where c(n) = ceiling(n) - floor(n)
    #                       1 2  2 1
    if ($line =~ s{\, where (c(hi)?)\(n\) (is|\=) ceiling.*}{ }) { # add a space for match below
      my $repl = $1;
      #                 1     2     2 1
      while ($line =~ m{($repl(\(\S+) )}) {
        my $chi  = quotemeta($1);
        my $parm = $2;
        $parm =~ s{\/}{\,};
        $line =~ s{$chi}                {eval2$parm };
        # print STDERR "chi=$chi, parm=$parm, line=$line\n";
      }
      $funct =    "fchi";
    }
    # (ceiling(n/(n-i-j)) - floor(n/(n-i-j))
    #                            1   1
    while ($line =~ m{\(ceiling\((\S+) *\- *floor\(\1\)}) {
      my $evparm = $1;
      $evparm =~ s{\/}{\,};
      #                     1   1
      my $s =
      $line =~      s{\(ceiling\((\S+) *\- *floor\(\1\)}{eval2\($evparm};
      if ($debug >= 1) {
        print STDERR "# $aseqno: standalone fchi, evparm=\"$evparm\", s=$s, line=$line\n"; 
      }
      $funct =    "fchi";
    }

    if ($line =~ s{sign\(floor\(}{Integer\.signum\(}) {
      $line =~ s{\)\)\)}{\)\)};
    }
    $line =~ s{sign\(}{Integer\.signum\(}g;
    $line =~ s{ mod 2\)}{ \& 1\)}g;
    $line =~ s{floor}{/* floor */}g;
    if ($line !~ m{Sum_|Integer}) {
      $line =~ s{\..*}{};
    }

    if (1 && ($line =~ s{SX_(\d+)\(\(}{SX_$1\(})) {
    } else {
      $line .= ")";
    }
    $line =~ s{[ \.]\)}{\)}g; # remove trailing dot
    $line =~     s{gcd\(}{Functions\.GCD\.i\(}g;
    $line =~     s{sqrt\(}{Functions\.SQRT\.i\(}g;
    # $line =~     s{floor\(}{\(}g; # remove remaining floors

    # $line =~ s{\, *where.*}{};

    if ($expand == 0) { # -x : do not expand, for teseting
      $nsum = $1;
      $parms[1] = $sx;
      $parms[2] = $line;
      $parms[4] = $withN;
      $callcode =   "wpartsf1";
      if (length($funct) == 0) {
        $callcode = "wpartsum";
      } elsif ($funct eq "f001221") {
      } elsif ($funct eq "f008966") {
      } elsif ($funct eq "f010051") {
      } elsif ($funct eq "f010052") {
      } elsif ($funct eq "f1chi") {
        $callcode = "wpartsf2";
      } else {
        print STDERR "# $aseqno: unknown function \"$funct\"\n";
      }
    } elsif ($sx =~ m{SX_(\d+)}) { # productive branch
      $nsum = $1;
      $parms[1] = "n -> " . $jsu[$nsum] . "ZV$line" .substr("))))))))))))))))", 0, $nsum);
      $parms[2] = "";
      $parms[4] = $withN;
      $callcode =   "wpartsf1";
      if (length($funct) == 0) {
        $callcode = "wpartsum";
        if (($line !~ m{\w\w}) || ($line !~ m{signum\(\([i-r]})) {
          $funct = "void";
        }
      } elsif ($funct eq "f001221") {
        $funct = "~~    ~~return Functions.OMEGA.i(i);";
      } elsif ($funct eq "f008966") {
        # $funct = "~~    ~~return Predicates.SQUARE_FREE.is(i) ? 1 : 0; // A008966";
        $funct = "~~    ~~return Math.abs(Functions.MOEBIUS.i(i)); // A008966";
      } elsif ($funct eq "f010051") {
        $funct = "~~    ~~return Z.valueOf(i).isProbablePrime() ? 1 : 0; // A010051";
      } elsif ($funct eq "f010052") {
        $funct = "~~    ~~return Predicates.SQUARE.is(i) ? 1 : 0; // A010052";
      } elsif ($funct eq "f1chi") {
        $callcode = "wpartsf2";
        $funct = "~~    ~~final Q qv = new Q(i, j);~~return 1 - qv.ceiling().intValue() + qv.floor().intValue(); // f1chi";
      } elsif ($funct eq "fchi") {
        $callcode = "wpartsf2";
        $funct = "~~    ~~final Q qv = new Q(i, j);~~return qv.ceiling().intValue() - qv.floor().intValue(); // fchi";
      } else {
        print STDERR "# $aseqno: unknown function \"$funct\"\n";
      }
    }

    # now apply the corrections,.c.f. sub below
    my $corr_code = $corr_hash{$aseqno};
    if (! defined($corr_code)) {
      # ignore
    } elsif ($corr_code == 1) {
      $funct = "~~    ~~return Functions.PrimePi.i(i) - Functions.PrimePi.i(i - 1); // corr. $corr_code";
    } elsif ($corr_code == 2) {
      $parms[1] =~ s{mu\(}{eval1\(};
    } elsif ($corr_code == 3) {
      $parms[1] =~ s{d\(}{Functions.SIGMA0.i\(}g;
    } elsif ($corr_code == 4) {
#     my $repl = quotemeta("(j^2 + i^2 +(n-i-j)^2)/n");
#     $parms[1] =~ s{$repl}{(j*j + i*i + (n-i-j)*(n-i-j)), n};
      $parms[1] =~ s{\(j\^2 *\+ *i\^2 *\+\(n\-i\-j\)\^2\)\/n}{(j*j + i*i + (n-i-j)*(n-i-j)), n};
    } else {
      print STDERR "# $aseqno: invalid correction code $corr_code in $aseqno\n";
    }
    $parms[3] = $funct; 
    $parms[5] = $type;
    print join("\t", $aseqno, $callcode, @parms) . "\n";
}
#----
sub corrections {
%corr_hash = qw(
A308809 1
A308854 1
A308919 1
A308974 1
A326455 1
A326540 1
A326678 1
A355199 1
A308903 2
A335230 3
A348541 4

); # corr_hash
} # corrections
#----
sub lowix { # return variable and lower index, i=j, j=k, k=1 etc., irsum = 0 for rightmost sum.
  my ($nsum, $irsum) = @_;
  my $result = "";
  if ($irsum < $nsum - 1) {
    $result = substr($letters, $irsum    , 1) . "=" . substr($letters, $irsum + 1, 1);
  } else {
    $result = substr($letters, $irsum    , 1) . "=1";
  }
  return $result;
} # lowix
#----
sub uppix { # return upper index (n-j-k)/2, irsum = 0 for rightmost sum
  my ($nsum, $irsum) = @_;
  my $result = "(n";
  if ($irsum < $nsum - 1) {
    for (my $ipos = $irsum + 2; $ipos <= $nsum; $ipos ++) {
      $result .= "-" . substr($letters, $ipos - 1, 1);
    } # for ipos
    $result .=")/" . ($irsum + 2);
  } else {
    $result = "n/" . ($nsum  + 1);
  }
  return $result;
} # uppix
#F A309689 a(n) = Sum_{j=1..floor(n/3)} Sum_{i=j..floor((n-j)/2)} ((i-1) mod 2).
#F A309518 a(n) = Sum_{k=1..floor(n/4)} Sum_{j=k..floor((n-k)/3)} Sum_{i=j..floor((n-j-k)/2)} (((i-1) mod 2) + ((j-1) mod 2) + ((k-1) mod 2) + ((n-i-j-k-1) mod 2)).
__DATA__
%F A363278 a(n) = Sum_{j=1..floor(n/3)} Sum_{i=j..floor((n-j)/2)} (c(i) + c(j) + c(n-i-j))
%F A363322 a(n) = Sum_{k=1..floor(n/4)} Sum_{j=k..floor((n-k)/3)} Sum_{i=j..floor((n-j-k)/2)} (c(i) + c(j) + c(k) + c(n-i-j-k)), where c(x) = [gcd(n,x) = 1] and [ ] is the Iverson bracket.
%F A363323 a(n) = Sum_{l=1..floor(n/5)} Sum_{k=l..floor((n-l)/4)} Sum_{j=k..floor((n-k-l)/3)} Sum_{i=j..floor((n-j-k-l)/2)} (c(i) + c(j) + c(k) + c(l) + c(n-i-j-k-l)), where c(x) = [gcd(n,x) = 1] and [ ] is the Iverson bracket.
%F A363324 a(n) = Sum_{m=1..floor(n/6)} Sum_{l=m..floor((n-m)/5)} Sum_{k=l..floor((n-l-m)/4)} Sum_{j=k..floor((n-k-l-m)/3)} Sum_{i=j..floor((n-j-k-l-m)/2)} (c(i) + c(j) + c(k) + c(l) + c(m) + c(n-i-j-k-l-m)), where c(x) = [gcd(n,x) = 1] and [ ] is the Iverson bracket.
%F A363325 a(n) = Sum_{o=1..floor(n/7)} Sum_{m=o..floor((n-o)/6)} Sum_{l=m..floor((n-m-o)/5)} Sum_{k=l..floor((n-l-m-o)/4)} Sum_{j=k..floor((n-k-l-m-o)/3)} Sum_{i=j..floor((n-j-k-l-m-o)/2)} (c(i) + c(j) + c(k) + c(l) + c(m) + c(o) + c(n-i-j-k-l-m-o)), where c(x) = [gcd(n,x) = 1] and [ ] is the Iverson bracket.
%F A363326 a(n) = Sum_{p=1..floor(n/8)} Sum_{o=p..floor((n-p)/7)} Sum_{m=o..floor((n-o-p)/6)} Sum_{l=m..floor((n-m-o-p)/5)} Sum_{k=l..floor((n-l-m-o-p)/4)} Sum_{j=k..floor((n-k-l-m-o-p)/3)} Sum_{i=j..floor((n-j-k-l-m-o-p)/2)} (c(i) + c(j) + c(k) + c(l) + c(m) + c(o) + c(p) + c(n-i-j-k-l-m-o-p)), where c(x) = [gcd(n,x) = 1] and [ ] is the Iverson bracket.
%F A363327 a(n) = Sum_{q=1..floor(n/9)} Sum_{p=q..floor((n-q)/8)} Sum_{o=p..floor((n-p-q)/7)} Sum_{m=o..floor((n-o-p-q)/6)} Sum_{l=m..floor((n-m-o-p-q)/5)} Sum_{k=l..floor((n-l-m-o-p-q)/4)} Sum_{j=k..floor((n-k-l-m-o-p-q)/3)} Sum_{i=j..floor((n-j-k-l-m-o-p-q)/2)} (c(i) + c(j) + c(k) + c(l) + c(m) + c(o) + c(p) + c(q) + c(n-i-j-k-l-m-o-p-q)), where c(x) = [gcd(n,x) = 1] and [ ] is the Iverson bracket.
%F A363328 a(n) = Sum_{r=1..floor(n/10)} Sum_{q=r..floor((n-r)/9)} Sum_{p=q..floor((n-q-r)/8)} Sum_{o=p..floor((n-p-q-r)/7)} Sum_{m=o..floor((n-o-p-q-r)/6)} Sum_{l=m..floor((n-m-o-p-q-r)/5)} Sum_{k=l..floor((n-l-m-o-p-q-r)/4)} Sum_{j=k..floor((n-k-l-m-o-p-q-r)/3)} Sum_{i=j..floor((n-j-k-l-m-o-p-q-r)/2)} (c(i) + c(j) + c(k) + c(l) + c(m) + c(o) + c(p) + c(q) + c(r) + c(n-i-j-k-l-m-o-p-q-r)), where c(x) = [gcd(n,x) = 1] and [ ] is the Iverson bracket.
                  Sum_{r=1..floor(n/10)} Sum_{q=r..floor((n-r)/9)} Sum_{p=q..floor((n-q-r)/8)} Sum_{o=p..floor((n-p-q-r)/7)} Sum_{m=o..floor((n-o-p-q-r)/6)} Sum_{l=m..floor((n-m-o-p-q-r)/5)} Sum_{k=l..floor((n-l-m-o-p-q-r)/4)} Sum_{j=k..floor((n-k-l-m-o-p-q-r)/3)} Sum_{i=j..floor((n-j-k-l-m-o-p-q-r)/2)}
%F A309436  lambdan 0 n -> Sum_{o=1..floor(n/7)} Sum_{m=o..floor((n-o)/6)} Sum_{l=m..floor((n-m-o)/5)} Sum_{k=l..floor((n-l-m-o)/4)} Sum_{j=k..floor((n-k-l-m-o)/3)} Sum_{i=j..floor((n-j-k-l-m-o)/2)} (A010051(i) + A010051(j) + A010051(k) + A010051(l) + A010051(m) + A010051(o) + A010051(n-i-j-k-l-m-o)).
%F A309437  lambdan 0 n -> Sum_{p=1..floor(n/8)} Sum_{o=p..floor((n-p)/7)} Sum_{m=o..floor((n-o-p)/6)} Sum_{l=m..floor((n-m-o-p)/5)} Sum_{k=l..floor((n-l-m-o-p)/4)} Sum_{j=k..floor((n-k-l-m-o-p)/3)} Sum_{i=j..floor((n-j-k-l-m-o-p)/2)} (A010051(i) + A010051(j) + A010051(k) + A010051(l) + A010051(m) + A010051(o) + A010051(p) + A010051(n-i-j-k-l-m-o-p)).
%F A309438  lambdan 0 n -> Sum_{q=1..floor(n/9)} Sum_{p=q..floor((n-q)/8)} Sum_{o=p..floor((n-p-q)/7)} Sum_{m=o..floor((n-o-p-q)/6)} Sum_{l=m..floor((n-m-o-p-q)/5)} Sum_{k=l..floor((n-l-m-o-p-q)/4)} Sum_{j=k..floor((n-k-l-m-o-p-q)/3)} Sum_{i=j..floor((n-j-k-l-m-o-p-q)/2)} (c(q) + c(p) + c(o) + c(m) + c(l) + c(k) + c(j) + c(i) + c(n-i-j-k-l-m-o-p-q)), where c = A010051.
%F A309439  lambdan 0 n -> Sum_{r=1..floor(n/10)} Sum_{q=r..floor((n-r)/9)} Sum_{p=q..floor((n-q-r)/8)} Sum_{o=p..floor((n-p-q-r)/7)} Sum_{m=o..floor((n-o-p-q-r)/6)} Sum_{l=m..floor((n-m-o-p-q-r)/5)} Sum_{k=l..floor((n-l-m-o-p-q-r)/4)} Sum_{j=k..floor((n-k-l-m-o-p-q-r)/3)} Sum_{i=j..floor((n-j-k-l-m-o-p-q-r)/2)} (A010051(r) + A010051(q) + A010051(p) + A010051(o) + A010051(m) + A010051(l) + A010051(k) + A010051(j) + A010051(i) + A010051(n-i-j-k-l-m-o-p-q-r)).

the following with $funct = PrimePi(i) - PrimePi(i - 1)
A308809  8  FAIL  ,8,9,10,22,24,26,42,30... ,1,1,1,2,2,2,3,2
A308854 10  FAIL  ,10,11,12,26,28,45,48,51... ,1,1,1,2,2,3,3,3
A308919 12  FAIL  ,12,13,14,30,32,51,72,57... ,1,1,1,2,2,3,4,3
A308974 14  FAIL  ,14,15,16,34,36,57,80,84... ,1,1,1,2,2,3,4,4
A326455 16  FAIL  ,16,17,18,38,40,63,88,92... ,1,1,1,2,2,3,4,4
A326540 18  FAIL  ,18,19,20,42,44,69,96,100...  ,1,1,1,2,2,3,4,4
A326678 20  FAIL  ,20,21,22,46,48,75,104,108... ,1,1,1,2,2,3,4,4
A355199  6  FAIL  ,6,7,8,18,10,22,24,26...  ,1,1,1,2,1,2,2,2


