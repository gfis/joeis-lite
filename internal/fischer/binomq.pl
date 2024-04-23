#!perl

# modify BI(Q, int) parameters
# @(#) $Id$
# 2024-04-22, Georg Fischer
use strict;
use integer;
use warnings;

while (<>) {
    s/\s+\Z//; # chompr
    my $line = $_;
    while ($line =~ m{BI\(([^\,]*\/[^\,]*)}) {
        my $biq = $1;
        $biq =~ s{ }{}g;
        my $quot = 1;
        map { # extract $quot  
                my $part = $_;
                if ($part =~ m{\/}) {
                    my ($num, $den) = split(/\//, $part);
                    $quot = &lcm($quot, $den);
                }
                $_
            } split(/([\+\-])/, $biq);
        # print "# biq=\"$biq\", quot=\"$quot\", parts=" . join("\|", split(/([\+\-])/, $biq)) . "\n" ;
        my @parts = map { # expand num and den via $quot
                my $part = $_;
                if (0) {
                } elsif ($part =~ m{\A[\+\-]\Z}) { 
                    # operator - pass through
                } elsif ($part =~ m{\/}) { # with quotient
                    my ($num, $den) = split(/\//, $part);
                    my $mult = $quot / $den;
                    $part = $mult > 1 ? "$num\*$mult" : $num;
                } else {
                    $part = "$part\*$quot";
                }
                $part
            } split(/([\+\-])/, $biq);
        $biq = "new Q(" . join("", @parts) . ", $quot)";
        # print "# \@parts=\"$biq\"\n";
        $line =~    s{BI\(([^\,]*\/[^\,]*)}{BI\($biq};
    }
    print "$line\n";
} # while <>
#--------
sub gcd { # from https://www.perlmonks.org/?node_id=109872
  my ($a, $b) = @_;
  ($a, $b) = ($b, $a) if $a > $b;
  while ($a) {
    ($a, $b) = ($b % $a, $a);
  }
  return $b;
} # gcd
#--------
sub lcm {
  my ($a, $b) = @_;
  return $a * $b / &gcd($a, $b);
} # lcm
__DATA__
%o A371988	lambdan	0	n -> RU(0, n, k -> BI(k/4+1/4, n)./(k + 1).*(BI(n, k)).*(ZV(16).^(n))).num()
%o A371990	lambdan	0	n -> RU(0, n, k -> BI(n/4+k/4+1/4, n)./(n + k + 1).*(BI(n, k)).*(ZV(16).^(n))).num()
%o A372087	lambdan	0	n -> RU(0, n, k -> BI(4*k/3-2/3, k).*(ZV(9).^(k)).*(BI(k, n-k)))./(k+1)).num()
%o A372105	lambdan	0	n -> RU(0, n, k -> BI(4*k/3-2/3, k).*(ZV(9).^(k)).*(BI(n-1, n-k)))./(k+1)).num()

