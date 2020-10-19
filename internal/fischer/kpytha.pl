#!perl
# Generate terms or parameters for A195770 and related k-Pythagorean triple sequences
# 2020-10-19, Georg Fischer
#
#:# Usage:
#:#   perl kpytha.pl [-k num[/den]] [-l {a|b|}] [-n 100] [-p] [-t] > output
#:#       -k factor, maybe negative, default 0
#:#       -l leg: a (default), b or c
#:#       -m maximum value of a (default 32)
#:#       -p primitive solutions only
#:#       -t print triples instead of b-file format 
#----------------
use strict;
use integer;
use warnings;

my $action = "gen";
my $knum   = 0;
my $kden   = 1;
my $leg    = 0; # a
my $maxa   = 32;
my $primit = 0;
my $triple = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{k}) {
        my $k = shift(@ARGV);
        $k =~ m{(\-?\d)(\/(\d+))?};
        $knum = $1;
        $kden = $3 || 1;
        $action = "comp";
    } elsif ($opt  =~ m{l}) {
        $leg = shift(@ARGV);
        $leg =~ tr{abc}{012};
    } elsif ($opt  =~ m{m}) {
        $maxa = shift(@ARGV);
    } elsif ($opt  =~ m{p}) {
        $primit = 1;
    } elsif ($opt  =~ m{t}) {
        $triple = 1;
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

if (0) {
#----------------
} elsif ($action eq "comp") {
    my %roots = ();
    foreach my $c (0..65535) {
        $roots{$c * $c} = $c;
    }
    my $index = 1;
    foreach my $a (1..$maxa) {
        my $a2 = $a * $a;
        my $limb = ($a2 + 1 - $a * $knum / $kden) / 2 + 1;
        if ($limb < $a) {
          $limb = $a + 128; # guessed
        }
        $limb = $a + 4096;
        foreach my $b ($a..$limb) {
            my $c2pot = $a2 + $b * $b + $a * $b * $knum / $kden;
            if ($c2pot >= $a2) {
                if (defined($roots{$c2pot})) {
                my $c = $roots{$c2pot};
                    if ($primit == 0 || 
                            (&gcd($a, $b) == 1 && &gcd($b, $c) == 1)) {
                        if ($triple) {
                            print "$index\t$a\t$b\t$c\n";
                        } else {
                            print "$index " . ($a, $b, $c)[$leg] . "\n";
                        }
                        $index ++;
                    }
                }
            }
        } # for $b
    } # for $a
#----------------
} elsif ($action eq "gen" ) {
    while (<DATA>) {
        s/\s+\Z//; # chompr
        my @parms = split(/\s+/);
        # no_more: next if $parms[1] != 0; # pure Pythagorean for the beginning
        foreach my $iparm (5..7) {
            #                 aseqno          callcode   ofs  leg         num        den        primit     1st triple
            print join ("\t", $parms[$iparm], $parms[0], 1,   $iparm - 5, $parms[1], $parms[2], $parms[3], $parms[4]) . "\n";
        } # for iparm
        if ($parms[1] == 0) {
            $primit ++;
        }
    } # while DATA
#----------------
} else {
    print "invalid action=\"$action\"\n";
}
#--------
sub gcd { # from https://www.perlmonks.org/?node_id=109872
  my ($a, $b) = @_;
  ($a,$b) = ($b,$a) if $a > $b;
  while ($a) {
    ($a, $b) = ($b % $a, $a);
  }
  return $b;
} # gcd
#------------------------------------------------
# 0     1   2   3     4       5       6       7
__DATA__
kpytha  0   1   false (3,4,5) A009004 A156681 A156682
kpytha  1   1   false (3,5,7) A195770 A195866 A195867
kpytha  3   1   false (3,7,11)    A196112 A196113 A196114
kpytha  4   1   false (3,8,13)    A196119 A196120 A196121
kpytha  5   1   false (1,3,5) A196155 A196156 A196157
kpytha  6   1   false (2,3,7) A196162 A196163 A196164
kpytha  7   1   false (1,1,3) A196169 A196170 A196171
kpytha  8   1   false (1,4,7) A196176 A196177 A196178
kpytha  9   1   false (1,15,19)   A196183 A196184 A196185
kpytha  10  1   false (1,2,5) A196238 A196239 A196240
kpytha  1   2   false (2,3,4) A195879 A195880 A195881
kpytha  3   2   false (5,18,22)   A195925 A195926 A195927
kpytha  1   3   false (3,8,9) A195939 A195940 A195941
kpytha  2   3   false (4,9,11)    A196001 A196002 A196003
kpytha  4   3   false (7,36,41)   A196040 A196041 A196042
kpytha  5   3   false (7,39,45)   A196088 A196089 A196090
kpytha  5   2   false (5,22,28)   A196026 A196027 A196028
kpytha  1   4   false (2,2,3) A196259 A196260 A196261
kpytha  3   4   false (2,6,7) A196252 A196253 A196254
kpytha  5   4   false (3,20,22)   A196098 A196099 A196100
kpytha  7   4   false (9,68,76)   A196105 A196106 A196107
kpytha  1   5   false (5,7,9) A196348 A196349 A196350
kpytha  1   8   false (4,10,11)   A196355 A196356 A196357
kpytha  -1  1   false (1,1,1) A195778 A195794 A195795
kpytha  -3  1   false (1,3,1) A196369 A196370 A196371
kpytha  -4  1   false (1,4,1  A196376 A196377 A196378
kpytha  -5  1   false (1,5,1) A196383 A196384 A196385
kpytha  -6  1   false (1,6,1) A196390 A196391 A196392
kpytha  -1  2   false (1,2,2) A195872 A195873 A195874
kpytha  -3  2   false (2,3,2) A195918 A195919 A195920
kpytha  -5  2   false (2,5,2) A196362 A196363 A196364
kpytha  -1  3   false (1,3,3) A195932 A195933 A195934
kpytha  -2  3   false (2,3,3) A195994 A195995 A195996
kpytha  -4  3   false (3,4,3) A196033 A196034 A196035
kpytha  -5  3   false (3,5,3) A196008 A196009 A196010
kpytha  -1  4   false (1,4,4) A196266 A196267 A196268
kpytha  -3  4   false (3,4,4) A196245 A196246 A196247
kpytha  0   1   true  (3,4,5) A020884 A156678 A156679
kpytha  1   1   true  (3,5,7) A195868 A195869 A195870
kpytha  3   1   true  (3,7,11)    A196115 A196116 A196117
kpytha  4   1   true  (3,8,13)    A196122 A196123 A196124
kpytha  5   1   true  (1,3,5) A196158 A196159 A196160
kpytha  6   1   true  (2,3,7) A196165 A196166 A196167
kpytha  7   1   true  (1,1,3) A196172 A196173 A196174
kpytha  8   1   true  (1,4,7) A196179 A196180 A196181
kpytha  9   1   true  (1,15,19)   A196186 A196187 A196188
kpytha  10  1   true  (1,2,5) A196241 A196242 A196243
kpytha  1   2   true  (2,3,4) A195882 A195883 A195884
kpytha  3   2   true  (5,18,22)   A195928 A195929 A195930
kpytha  1   3   true  (3,8,9) A195990 A195991 A195992
kpytha  2   3   true  (4,9,11)    A196004 A196005 A196006
kpytha  4   3   true  (7,36,41)   A196043 A196044 A196045
kpytha  5   3   true  (7,39,45)   A196091 A196092 A196093
kpytha  5   2   true  (5,22,28)   A196029 A196030 A196031
kpytha  1   4   true  (2,2,3) A196262 A196263 A196264
kpytha  3   4   true  (2,6,7) A196255 A196256 A196257
kpytha  5   4   true  (3,20,22)   A196101 A196102 A196103
kpytha  7   4   true  (9,68,76)   A196108 A196109 A196110
kpytha  1   5   true  (5,7,9) A196351 A196352 A196353
kpytha  1   8   true  (4,10,11)   A196358 A196359 A196360
kpytha  -1  1   true  (1,1,1))    A195796 A195862 A195863
kpytha  -3  1   true  (1,3,1) A196372 A196373 A196374
kpytha  -4  1   true  (1,4,1  A196379 A196380 A196381
kpytha  -5  1   true  (1,5,1) A196386 A196387 A196388
kpytha  -6  1   true  (1,6,1) A196393 A196394 A196395
kpytha  -1  2   true  (1,2,2) A195875 A195876 A195877
kpytha  -3  2   true  (2,3,2) A195921 A195922 A195923
kpytha  -5  2   true  (2,5,2) A196365 A196366 A196367
kpytha  -1  3   true  (1,3,3) A195935 A195936 A195937
kpytha  -2  3   true  (2,3,3) A195997 A195998 A195999
kpytha  -4  3   true  (3,4,3) A196036 A196037 A196038
kpytha  -5  3   true  (3,5,3) A196084 A196085 A196086
kpytha  -1  4   true  (1,4,4) A196269 A196270 A196271
kpytha  -3  4   true  (3,4,4) A196248 A196249 A196250
