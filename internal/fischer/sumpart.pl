#!perl
# 2025-03-10, Georg Fischer
use strict;
use warnings;
use integer;

my $letters = "ijklmopqrstuvwxyz";
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
  # print "# jOEIS[$nsum]: $jsu[$nsum]\n";
  # print "#  OEIS[$nsum]: $nsu[$nsum]\n";
    print "#  OEIS[$nsum]: $noeis\n";
} # for nsum
# exit(0);
               
my $nsum;
while (<>) {
    s/\s+\Z//; # chompr
    s{^[\#\%][NFC] }{}; # remove type
    my $line = $_;  
    $line =~ s{\(n\-1\)\/4}{(n-l)/4}g; # correction!
    $line =~ s{\(n\-k\-l\-m\-o\)\/3\}}{(n-k-l-m-o)/3)\}}g; # correction!
    $line =~ s{\. *\(End\) *}{};
    
    if ($line =~ m{\/(\d+)}) {
      $nsum = $1 - 1;
      $line =~ s{$nsu[$nsum]}{SX_$nsum\(};
    }                      

    if ($line =~ s{\, where mu.*}{}) {
      $line =~ s{mu\(([^\)]+)\)\^2}{F008966\($1\)}g;      # SQUARE_FREE.is
    }
    if ($line =~ s{\, where omega.*}{}) {
      $line =~ s{mu\(([^\)]+)\)\^2}{F008966\($1\)}g;      # SQUARE_FREE.is
    }                                                
    #                 1      1 2             3     3                             2  
    if ($line =~ s{\, (where )?(c = A010051|c(\(n\))? is the prime characteristic).*}{}) {
      $line =~ s{c\(([^\)]+)\)}{A010051\($1\)}g;          # PRIME.is
    }
 
    #                 1      1 2             3     3                             2  
    if ($line =~ s{\, (where )?(c = A010051|c(\(n\))? is the prime characteristic).*}{}) {
      $line =~ s{c\(([^\)]+)\)}{A010051\($1\)}g;          # PRIME.is
    } 
    
    # where c(n) = 1 - ceiling(n) + floor(n))
    #                       1 2  2 1
    if ($line =~ s{\, where (c(hi)?)\(n\) (is|\=) 1 \- ceiling.*}{ }) { # add a space for match below
      my $repl = $1;                  
      #                 1     2     2 1
      while ($line =~ m{($repl(\(\S+) )}) {        
        my $chi  = quotemeta($1);
        my $parm = $2;
        $parm =~ s{\/}{\,};
        $line =~ s{$chi}{CHI$parm }; 
        # print "chi=$chi, parm=$parm, line=$line\n"; 
      }
    }

    if ($line =~ s{sign\(floor\(}{Integer\.signum\(}) {
      $line =~ s{\)\)\)}{\)\)};
    }                                           
    $line =~ s{sign\(}{Integer\.signum\(}g;
    $line =~ s{ a\(n\) \= }                               {\tlambdan\t0\tn \-\> };
    $line =~ s{ mod 2\)}{ \& 1\)}g;
    if ($line !~ m{Sum_|Integer}) {
      $line =~ s{\..*}{};
    }
    if (1 && ($line =~ s{SX_(\d+)\(\(}{SX_$1\(})) {
    } else {
      $line .= ")";
    } 
    $line =~ s{[ \.]\)}{\)}g;
  if (0) {
    $line =~ s{\, *where.*}{}; 
    #                1   1  2   2           3      3
    $line =~ s{Sum_\{(\w+)\=(\w+)\.\.floor\((\D+\d+)\)\}} {SU\($2, $3, $1 \-\>}g;
    #             1      1
    $line =~ s{c\(([^\)]+)\)}                             {\(\(Functions\.GCD\.i\(n, $1\) == 1) \? 1 \: 0\)}g;
    #          1         1
    $line =~ s{(\-\>\s*\()}                               {\-\> ZV\(}g;
  }
    my $sucount = ($line =~ s{SU}{SU}g);
    $line .= ")" x $sucount;
    print "$line\n";
}
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
