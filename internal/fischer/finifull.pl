#!perl

# Ensure length of constants for Java
# @(#) $Id$
# 2021-08-12: for noncomp, bref also
# 2020-01-22, Georg Fischer
#
# Java: valid int range is -2,147,483,648 to 2,147,483,647 (-2^31 to 2^31� 1) 
#     -> long if size > 9  digits.
# Java long max values are -9,223,372,036,854,775,807 and 9,223,372,036,854,775,808. 
#     -> Z    if size > 18 digits
#
#:# Usage:
#:#   perl finifull.pl $@.tmp > $@.gen
#:#       insert "L" or "new Z()" in $(PARM1) if necessary
#---------------------------------
use strict;
use integer;
use warnings;

my $aseqno;
my $line;
my $width = 128; # for line breaking (nyi)
my $max_len = 8192; # size for seq4.parm1 field

# explict Z names for small terms
my @anum = qw (
  ZERO 
  ONE  
  TWO  
  THREE
  FOUR 
  FIVE 
  SIX  
  SEVEN
  EIGHT
  NINE 
  TEN  
  );

# while(<DATA>) {
while(<>) {
    s{\s+\Z}{}; # chompr
    $line = $_;
    next if $line =~ m{^\s*\#};
    my  ($aseqno, $callcode, $offset, $init, @rest) = split(/\t/, $line);
    my  $isZ = 0;
    my $len = 0;
    my  $init2 = join(",", 
            map {
                my $term = $_;
                if (0) {
                } elsif (length($term) >= 18) {
                    $isZ = 1;
                } elsif (length($term) >=  9) {
                    $term .= "L";
                }
                $len += 2 + length($term);
                if ($len >= $width) {
                    # $term = "\n      $term"; # not because that breaks lines for gen_seq4.pl
                    $len = 0;
                }
                $term
            } split(/\,/, $init));
    if ($isZ == 1) {
        $init2 = "new Z[]{" . join(",", 
            map {
                my $term = $_;
                if (0) {
                } elsif ($term eq "-1") {
                    $term = "Z.NEG_ONE";
                } elsif ($term >= 0 && $term <= 10) {
                    $term = "Z.$anum[$term]";
                } else {
                    $term = "new Z(\"$term\")";
                }
                $len += 2 + length($term);
                if ($len >= $width) {
                    # $term = "\n      $term"; 
                    $len = 0;
                }
                $term
            } split(/\,/, $init)) . "}";
    }
    if (length($init2) <= $max_len) {
        print join("\t", ($aseqno, $callcode, $offset, $init2, @rest)) . "\n";
    } else {
        print STDERR "# $aseqno: termlist > $max_len characters\n";
    }
} # while
__DATA__
A029722	finifull	1	1000,1000000000,1000000000000000000000000000,100,1,4,8,3,5,-1,-1,11,1000000,1,1,1000000000000000000000000,1000000000000000,3,6,2,4,5,2,6,20,-1	Smallest positive integer containing the n-th letter of the alphabet (in English), or -1 if no such integer exists.
A032354	finifull	0	0,1728,-3375,8000,-32768,54000,287496,-884736,-12288000,16581375,-884736000,-147197952000,-262537412640768000	j-invariants for orders of class number 1.
A032437	finifull	1	3,7,13,17,37,73,97,113,137,173,197,313,317,337,373,397,773,797,937,997,1373,1997,3137,3313,3373,3797,7937,9137,9173,9337,9397,13313,33797,39397,79337,79397,91373,91997,99137,99173,99397,139397,379397,391373,399137,399173,739397,933797,979337,3399173,3739397,9139397,9391373,9979337,33739397,39979337,99979337,933739397	Substrings from the right are prime numbers (using only odd digits different from 5).
A032784	finifull	1	0,2,5,7,8,11,12,17,19,22,26,32,33,35,44,47,55,62,68,77,82,89,107,110,116,117,132,143,152,176,187,197,215,242,257,264,278,297,332,341,362,407,418,440,467,539,572,602,607,656,737,782,803,845,902,957,1007,1034,1097,1232,1265,1331,1342,1412,1507,1628,1727,1832,1979,2112,2222,2357,2420,2717,2882,2959,3032,3113,3302,3707,3806,4037,4247,4532,4895,5192,5507,5948,6347,6677,6732,7082,7271,8162,8657,8888,9350,9917,10582,11132,11429,12122,13607,14696,14817,15587,16532,19052,20207,21257,21824,24497,25982,26675,29762,31757,33407,34298,36377,40832,44462,46772,49607,57167,60632,65483,73502,74107,77957,80036,95282,102905,109142,122507,133397,148832,171512,181907,222332,233882,240119,285857,327437,367532,400202,514547,545732,667007,720368,857582,1200617,1637207,2001032,2572757,3601862,6003107,18009332	Numbers k 