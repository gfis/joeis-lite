#!perl

# Generate a seq4 record for a rational g.f.
# 2021-01-25, Georg Fischer
#
#:# Usage:
#:#   perl gengf.pl [-d debug] [-cc callcode] [-r powerdiv] [-f appendfile] a027672.gf >> molien.man
#:#   The input file must contain a comment line with the A-number.
#----------------------------------------------------------------
use strict;
use integer;
use warnings;

my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min);

my $PFRACT = "java -cp ../../../ramath/dist/ramath.jar org.teherba.ramath.symbolic.PolyFraction ";
my $debug = 0;
my $disempow = 1;
my $aseqno = "A000000";
my $callcode = "molien";
my $appendfile = "molien.man";
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{a}) {
        $aseqno    = shift(@ARGV);
    } elsif ($opt  =~ m{cc}) {
        $callcode  = shift(@ARGV);
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{f}) {
        $appendfile= shift(@ARGV);
    } elsif ($opt  =~ m{r}) {
        $disempow  = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
#----------------
my $buffer = "";
while(<>) { # assemble the PolyFraction string
    s{[ \;]}{}g; # remove space and ";"
    my $line = $_;
    if ($line =~ m{\A\s*(\#|\(\*)}) { # comment line
        $line =~ m{(A\d\d\d\d\d\d+)}; # grep the A-number
        $aseqno = $1;
    } else {
        $buffer .= $line;
    }
} # while

print     "$PFRACT -r $disempow -parse \"buffer\"\n";
my $cmd = "$PFRACT -r $disempow -parse \"$buffer\"";
my @result = split(/\r?\n/, `$cmd`);
foreach my $line (@result) {
    if ($debug >= 1) {
        print "$line\n";
    }
    if (0) {
    } elsif ($line =~ m{\Avectors\: *(\[[^\]]*\])\, *(\[[^\]]*\])}) {
        my ($num, $den) = ($1, $2);
        open(APP, ">>", $appendfile) || die "cannot append to $appendfile";
        print APP join("\t", $aseqno, $callcode, 0, $num, $den) . "\n";
        close(APP);
    }
} # foreach result line

__DATA__
java -cp ../../../ramath/dist/ramath.jar org.teherba.ramath.symbolic.PolyFraction -n 46 -coeff "1 + x^1 + 6*x^3 + 30*x^4 + 57*x^5 + 207*x^6 + 565*x^7 + 1000*x^8 + 2031*x^9 + 3880*x^10 + 5804*x^11 + 8696*x^12 + 12991*x^13 + 16595*x^14 + 20527*x^15 + 25965*x^16 + 29418*x^17 + 31536*x^18 + 34772*x^19 + 35273*x^20 + 33093*x^21 + 31969*x^22 + 29068*x^23 + 23862*x^24 + 20052*x^25 + 16217*x^26 + 11369*x^27 + 7996*x^28 + 5554*x^29 + 3097*x^30 + 1642*x^31 + 930*x^32 + 350*x^33 + 104*x^34 + 51*x^35 + 9*x^36 + x^37 + x^38" "- x^2 - 4*x^3 + 2*x^5 + 6*x^6 + 2*x^7 + 2*x^8 - 6*x^9 - 7*x^10 - 6*x^11 + 8*x^12 + 8*x^13 + 3*x^14 - 8*x^15 - 6*x^16 - 6*x^17 + 3*x^18 + 12*x^19 + 15*x^20 - 15*x^22 - 12*x^23 - 3*x^24 + 6*x^25 + 6*x^26 + 8*x^27 - 3*x^28 - 8*x^29 - 8*x^30 + 6*x^31 + 7*x^32 + 6*x^33 - 2*x^34 - 2*x^35 - 6*x^36 - 2*x^37 + 4*x^39 + x^40 - x^42 + 1"
(x + 6*x^3 + 30*x^4 + 57*x^5 + 207*x^6 + 565*x^7 + 1000*x^8 + 2031*x^9 + 3880*x^10 + 5804*x^11 + 8696*x^12 + 12991*x^13 + 16595*x^14 + 20527*x^15 + 25965*x^16 + 29418*x^17 + 31536*x^18 + 34772*x^19 + 35273*x^20 + 33093*x^21 + 31969*x^22 + 29068*x^23 + 23862*x^24 + 20052*x^25 + 16217*x^26 + 11369*x^27 + 7996*x^28 + 5554*x^29 + 3097*x^30 + 1642*x^31 + 930*x^32 + 350*x^33 + 104*x^34 + 51*x^35 + 9*x^36 + x^37 + x^38 + 1) / ( - x^2 - 4*x^3 + 2*x^5 + 6*x^6 + 2*x^7 + 2*x^8 - 6*x^9 - 7*x^10 - 6*x^11 + 8*x^12 + 8*x^13 + 3*x^14 - 8*x^15 - 6*x^16 - 6*x^17 + 3*x^18 + 12*x^19 + 15*x^20 - 15*x^22 - 12*x^23 - 3*x^24 + 6*x^25 + 6*x^26 + 8*x^27 - 3*x^28 - 8*x^29 - 8*x^30 + 6*x^31 + 7*x^32 + 6*x^33 - 2*x^34 - 2*x^35 - 6*x^36 - 2*x^37 + 4*x^39 + x^40 - x^42 + 1)
vectors: [1,1,0,6,30,57,207,565,1000,2031,3880,5804,8696,12991,16595,20527,25965,29418,31536,34772,35273,33093,31969,29068,23862,20052,16217,11369,7996,5554,3097,1642,930,350,104,51,9,1,1],[1,0,-1,-4,0,2,6,2,2,-6,-7,-6,8,8,3,-8,-6,-6,3,12,15,0,-15,-12,-3,6,6,8,-3,-8,-8,6,7,6,-2,-2,-6,-2,0,4,1,0,-1]
coefficients: [1,1,1,11,35,70,278,765,1526,3774,8105,14633,28560,51983,85609,145591,237609,364095,565831,855788,1240383,1808777,2587237,3590112,4992854,6844101,9172450,12296446,16300139,21235896,27646466,35669378,45394358,57699934,72801345,90844339,113192127,140169225,172002336,210733077,256835563,310649907,375142851,450988649,538682173,642423935]

