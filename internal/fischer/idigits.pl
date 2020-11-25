#!perl
# Generate parameters for A217157 ff.
# 2020-11-24, Georg Fischer: copied from kpatha.pl
#
#:# Usage:
#:#   perl idigits.pl [-d mode] > $@.gen
#:#       -d debugging mode: 0 = none, 1 = some, 2 = more
#----------------
use strict;
use integer;
use warnings;

my $debug  = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt =     shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug  = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my %numbers = qw (two 2 three 3 four 4 five 5 six 6 seven 7 eight 8 nine 9 ten 10 n 0);
my ($features, $count, $base);

while (<>) {
    s/\s+\Z//; # chompr
    next if ! m{\AA\d+}; # if not starting with A-number
    my ($aseqno, $superclass, $name, @rest) = split(/\t/);
    $name =~ s{ or more}{};
    $name =~ s{ \(at least\)}{};
    $name =~ s{ \(from the left\)}{};
    ($count, $features, $base) = (0, 0, 0);
    my $object;
    if (0) {
    } elsif ($name =~ m{\Aa\(n\) is the least value of k such that the decimal expansion of n\^k contains (\w+) consecutive}) {
        # A217164	null	a(n) is the least value of k such that the decimal expansion of n^k contains nine consecutive identical digits. nonn,base,  2..100  null
        $object   = "n^k";
        $count    = $numbers{$1};
        $features = 0x01;
        $features |= &high_nibble($object);
    } elsif ($name =~ m{\Aa\(n\) is the first digit to appear (\w+) times in succession in the (decimal )?representation of n\^}) {
        # A217167	null	a(n) is the first digit (from the left) to appear two times in succession in the decimal representation of n^A217157(n).    nonn,base,  2..10000    null
        $object   = "n^k";
        $count    = $numbers{$1};
        $features = 0x02;
        $features |= &high_nibble($object);
    } elsif ($name =~ m{\Aa\(n\) is the number of digits in the decimal representation of the smallest power of n that contains (\w+) consecutive}) {
        # A217177	null	a(n) is the number of digits in the decimal representation of the smallest power of n that contains two consecutive identical digits.   nonn,base,  2..10000    null
        $object   = "n^k";
        $count    = $numbers{$1};
        $features = 0x03;
        $features |= &high_nibble($object);
    #                                            1              2                                3
    } elsif ($name =~ m{\Aa\(n\) is the smallest (\w) for which (the decimal representation of )?(\d+)\^\w contains [k-n] consecutive }) {
        # A045875	null	a(n) is the smallest m for which the decimal representation of 2^m contains n consecutive identical digits.
        # A215727	null	a(n) is the smallest m for which 3^m contains n consecutive identical digits.   nonn,base,more,changed,synth    1..17   null
        $base     = $3;
        $object   = "2^n";
        $count    = -1;
        $features = 0x01;
        $features |= &high_nibble($object);
    } elsif ($name =~ m{\Aa\(n\) is the first digit to appear n times in succession in a power of (\d+)}) {
        # A215732	null	a(n) is the first digit to appear n times in succession in a power of 2.    nonn,base,hard,more,changed,synth   1..15   null
        $base     = $1;
        $object   = "2^n";
        $count    = -1;
        $features = 0x02;
        $features |= &high_nibble($object);
    } elsif ($name =~ m{\Aa\(n\) is the number of digits in the decimal representation of the smallest power of (\d+)}) {
        # A217185	null	a(n) is the number of digits in the decimal representation of the smallest power of 2 that contains n consecutive identical digits. nonn,base,synth 1..14   null
        $base     = $1;
        $object   = "2^n";
        $count    = -1;
        $features = 0x03;
        $features |= &high_nibble($object);
    } elsif ($name =~ m{(Fibon|Lucas)}) {
        $object   = $1;
        $count    = -1;
        # print "# $aseqno $object $name\n";
        # A217165	null	a(n) is the least value of k such that the decimal expansion of Fibonacci(k) contains n consecutive identical digits.   nonn,base,hard,synth    1..11   null
        if (0) {
        } elsif ($name =~ m{\Aa\(n\) is the least value}) {
            $features = 0x01;
        } elsif ($name =~ m{\Aa\(n\) is the first digit}) {
            $features = 0x02;
        } elsif ($name =~ m{\Aa\(n\) is the number of digits}) {
            $features = 0x03;
        }
        $features |= &high_nibble($object);
    }
    if ($count != 0) {
        print join("\t", $aseqno, "idigits", 0, sprintf("0x%2x", $features), $count, $base) . "\n";
    } 
} # while DATA
# end of main
#================================
sub high_nibble {
    my ($object) = @_;
    my $result = 0;
    if (0) {
    } elsif ($object =~ m{[k-n]\^\w|power of [k-n]}) {
      $result = 0x10;
    } elsif ($object =~ m{2\^n}) {
      $result = 0x20;
    } elsif ($object =~ m{Fibon}) {
      $result = 0x30;
    } elsif ($object =~ m{Lucas}) {
      $result = 0x40;
    }
    return $result;
} # high_nibble
#----
__DATA__
xxxx A217157	null	a(n) is the least value of k such that the decimal expansion of n^k contains two consecutive identical digits.  nonn,base,changed,  2..10000    null
xxxx A217158	null	a(n) is the least value of k such that the decimal expansion of n^k contains three consecutive identical digits.    nonn,base,  2..10000    null
xxxx A217159	null	a(n) is the least value of k such that the decimal expansion of n^k contains four consecutive identical digits. nonn,base,  2..10000    null
xxxx A217160	null	a(n) is the least value of k such that the decimal expansion of n^k contains five consecutive identical digits. nonn,base,  2..10000    null
xxxx A217161	null	a(n) is the least value of k such that the decimal expansion of n^k contains six consecutive identical digits.  nonn,base,  2..10000    null
xxxx A217162	null	a(n) is the least value of k such that the decimal expansion of n^k contains seven consecutive identical digits.    nonn,base,  2..1000 null
xxxx A217163	null	a(n) is the least value of k such that the decimal expansion of n^k contains eight or more consecutive identical digits.    nonn,base,  2..100  null
xxxx A217164	null	a(n) is the least value of k such that the decimal expansion of n^k contains nine consecutive identical digits. nonn,base,  2..100  null
xxxx 
xxxx A217167	null	a(n) is the first digit (from the left) to appear two times in succession in the decimal representation of n^A217157(n).    nonn,base,  2..10000    null
xxxx A217168	null	a(n) is the first digit (from the left) to appear three times in succession in the decimal representation of n^A217158(n).  nonn,base,  2..10000    null
xxxx A217169	null	a(n) is the first digit (from the left) to appear four times in succession in the decimal representation of n^A217159(n).   nonn,base,  2..10000    null
xxxx A217170	null	a(n) is the first digit (from the left) to appear five times in succession in the decimal representation of n^A217160(n).   nonn,base,  2..10000    null
xxxx A217171	null	a(n) is the first digit (from the left) to appear six times in succession in the decimal representation n^A217161(n).   nonn,base,  2..10000    null
xxxx A217172	null	a(n) is the first digit (from the left) to appear seven times in succession in the decimal representation of n^A217162(n).  nonn,base,  2..1000 null
xxxx A217173	null	a(n) is the first digit (from the left) to appear eight times in succession in the decimal representation of n^A217163(n).  nonn,base,synth 2..88   null
xxxx A217174	null	a(n) is the first digit (from the left) to appear nine times in succession in the decimal representation of n^A217164(n).   nonn,base,synth 2..88   null
xxxx 
xxxx A217177	null	a(n) is the number of digits in the decimal representation of the smallest power of n that contains two consecutive identical digits.   nonn,base,  2..10000    null
xxxx A217178	null	a(n) is the number of digits in the decimal representation of the smallest power of n that contains three consecutive identical digits. nonn,base,  2..10000    null
xxxx A217179	null	a(n) is the number of digits in the decimal representation of the smallest power of n that contains four consecutive identical digits.  nonn,base,  2..10000    null
xxxx A217180	null	a(n) is the number of digits in the decimal representation of the smallest power of n that contains five consecutive identical digits.  nonn,base,  2..10000    null
xxxx A217181	null	a(n) is the number of digits in the decimal representation of the smallest power of n that contains six consecutive identical digits.   nonn,base,  2..10000    null
xxxx A217182	null	a(n) is the number of digits in the decimal representation of the smallest power of n that contains seven consecutive identical digits. nonn,base,  2..1000 null
xxxx A217183	null	a(n) is the number of digits in the decimal representation of the smallest power of n that contains eight consecutive identical digits. nonn,base,  2..100  null
xxxx A217184	null	a(n) is the number of digits in the decimal representation of the smallest power of n that contains nine consecutive identical digits.  nonn,base,  2..100  null
#----
xxxx A045875	null	a(n) is the smallest m for which the decimal representation of 2^m contains n consecutive identical digits.
xxxx A215727	null	a(n) is the smallest m for which 3^m contains n consecutive identical digits.   nonn,base,more,changed,synth    1..17   null
xxxx A215728	null	a(n) is the smallest m for which 5^m contains n consecutive identical digits.   nonn,base,more,changed,synth    1..16   null
xxxx A215729	null	a(n) is the smallest m for which 6^m contains (at least) n consecutive identical digits.    nonn,base,more,changed,synth    1..14   null
xxxx A215730	null	a(n) is the smallest m for which 7^m contains n consecutive identical digits.   nonn,base,hard,changed,synth    1..15   null
xxxx A215731	null	a(n) is the smallest m for which the decimal representation of 11^m contains n consecutive identical digits.    nonn,base,more,changed,synth    1..15   null

xxxx A215732	null	a(n) is the first digit to appear n times in succession in a power of 2.    nonn,base,hard,more,changed,synth   1..15   null
xxxx A215733	null	a(n) is the first digit to appear n times in succession in a power of 3.    nonn,base,more,changed,synth    1..17   null
xxxx A215734	null	a(n) is the first digit to appear n times in succession in a power of 5.    nonn,base,more,changed,synth    1..16   null
xxxx A215735	null	a(n) is the first digit to appear n times in succession in a power of 6.    nonn,base,more,changed,synth    1..14   null
xxxx A215736	null	a(n) is the first digit to appear n times in succession in a power of 7.    nonn,base,more,changed,synth    1..15   null
xxxx A215737	null	a(n) is the first digit to appear n times in succession in a power of 11.   nonn,more,base,changed,synth    1..15   null

xxxx A217185	null	a(n) is the number of digits in the decimal representation of the smallest power of 2 that contains n consecutive identical digits. nonn,base,synth 1..14   null
xxxx A217186	null	a(n) is the number of digits in the decimal representation of the smallest power of 3 that contains n consecutive identical digits. nonn,base,more,synth    1..12   null
xxxx A217187	null	a(n) is the number of digits in the decimal representation of the smallest power of 5 that contains n consecutive identical digits. nonn,base,synth 1..12   null
xxxx A217188	null	a(n) is the number of digits in the decimal representation of the smallest power of 6 that contains n consecutive identical digits. nonn,base,synth 1..11   null
xxxx A217189	null	a(n) is the number of digits in the decimal representation of the smallest power of 7 that contains n consecutive identical digits. nonn,base,synth 1..10   null
xxxx A217190	null	a(n) is the number of digits in the decimal representation of the smallest power of 11 that contains n consecutive identical digits.    nonn,base,synth 1..13   null
#----
A217165	null	a(n) is the least value of k such that the decimal expansion of Fibonacci(k) contains n consecutive identical digits.   nonn,base,hard,synth    1..11   null
A217166	null	a(n) is the least value of k such that the decimal expansion of Lucas(k) contains n consecutive identical digits.   nonn,base,hard,synth    1..11   null

A217175	null	a(n) is the first digit (from the left) to appear n times in succession in the decimal representation of the Fibonacci(A217165(n)). nonn,base,hard,synth    1..11   null
A217176	null	a(n) is the first digit (from the left) to appear n times in succession in the decimal representation of the Lucas(A217166(n)). nonn,base,hard,synth    1..11   null
       	    	
A217191	null	a(n) is the number of digits in the decimal representation of the smallest Fibonacci number that contains n consecutive identical digits.   nonn,base,hard,synth    1..11   null
A217192	null	a(n) is the number of digits in the decimal representation of the smallest Lucas number that contains n consecutive identical digits.   nonn,base,hard,synth    1..11   null

#----
manually A215236	null	Greatest integer k such that n^i has no identical consecutive digits for i = 0..k.  nonn,base,  2..10000    null
#----
not yet implemented:
A216063	null	a(n) is the conjectured highest power of n which has no two identical digits in succession. nonn,base,  2..1000 null
A216064	null	a(n) is the conjectured highest power of n which has no three identical digits in succession.   nonn,base,  2..99   null
A216065	null	a(n) is the conjectured highest power of n which has no four identical digits in succession.    nonn,base,synth 2..49   null
       	    	
A216137	null	a(n) = conjectured number of integers k such that n^k has no two consecutive identical digits.  nonn,base,  2..1000 null
A216138	null	a(n) = conjectured number of integers k such that n^k has no three consecutive identical digits.    nonn,base,  2..99   null
A216139	null	a(n) = conjectured number of integers k such that n^k has no four consecutive identical digits. nonn,base,synth 2..50   null

A216140	null	Conjectured number of digits in highest power of n with no two consecutive identical digits.    nonn,base,  2..1000 null
A216141	null	Conjectured number of digits in highest power of n with no three consecutive identical digits.  nonn,base,  2..99   null
A216142	null	Conjectured number of digits in highest power of n with no four consecutive identical digits.   nonn,base,synth 2..45   null
       	    	
