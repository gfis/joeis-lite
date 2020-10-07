#!perl

# Prepare the generation of calls of McKayThompsonSequence.java
# @(#) $Id$
# 2020-10-06, Georg Fischer
#
# Partially copied from David A. Madore's moonshine.py; cf. mckay_tables.pl

use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

# This is the list of the 172 conjugacy classes of cyclic subgroups of
# the Monster, in ATLAS notation:
my @classes = (
    "1A", "2A", "2B", "3A", "3B", "3C",
    "4A", "4B", "4C", "4D", "5A", "5B",
    "6A", "6B", "6C", "6D", "6E", "6F", "7A", "7B",
    "8A", "8B", "8C", "8D", "8E", "8F", "9A", "9B",
    "10A", "10B", "10C", "10D", "10E", "11A",
    "12A", "12B", "12C", "12D", "12E", "12F", "12G", "12H", "12I", "12J",
    "13A", "13B", "14A", "14B", "14C", "15A", "15B", "15C", "15D",
    "16A", "16B", "16C", "17A", "18A", "18B", "18C", "18D", "18E", "19A",
    "20A", "20B", "20C", "20D", "20E", "20F", "21A", "21B", "21C", "21D",
    "22A", "22B", "23AB",
    "24A", "24B", "24C", "24D", "24E", "24F", "24G", "24H", "24I", "24J",
    "25A", "26A", "26B", "27A", "27B", "28A", "28B", "28C", "28D", "29A",
    "30A", "30B", "30C", "30D", "30E", "30F", "30G", "31AB",
    "32A", "32B", "33A", "33B", "34A", "35A", "35B",
    "36A", "36B", "36C", "36D", "38A", "39A", "39B", "39CD",
    "40A", "40B", "40CD", "41A", "42A", "42B", "42C", "42D",
    "44AB", "45A", "46AB", "46CD", "47AB",
    "48A", "50A", "51A", "52A", "52B", "54A", "55A",
    "56A", "56BC", "57A", "59AB",
    "60A", "60B", "60C", "60D", "60E", "60F", "62AB", "66A", "66B",
    "68A", "69AB", "70A", "70B", "71AB", "78A", "78BC",
    "84A", "84B", "84C", "87AB", "88AB",
    "92AB", "93AB", "94AB", "95AB",
    "104AB", "105A", "110A", "119AB"
    );
# We bootstrap with a few known coefficients:
my  %bootcoefs = ();
    $bootcoefs{"1A"} = "0,196884,21493760L,864299970L,20245856256L,333202640600L";
    $bootcoefs{"2A"} = "0,4372,96256,1240002L,10698752L,74428120L";
    $bootcoefs{"2B"} = "0,276,-2048,11202,-49152,184024";
    $bootcoefs{"3A"} = "0,783,8672,65367,371520,1741655";
    $bootcoefs{"3B"} = "0,54,-76,-243,1188,-1384";
    $bootcoefs{"3C"} = "0,0,248,0,0,4124";
    $bootcoefs{"4A"} = "0,276,2048,11202,49152,184024";
    $bootcoefs{"4B"} = "0,52,0,834,0,4760";
    $bootcoefs{"4C"} = "0,20,0,-62,0,216";
    $bootcoefs{"4D"} = "0,-12,0,66,0,-232";
    $bootcoefs{"5A"} = "0,134,760,3345,12256,39350";
    $bootcoefs{"5B"} = "0,9,10,-30,6,-25";
    $bootcoefs{"6A"} = "0,79,352,1431,4160,13015";
    $bootcoefs{"6B"} = "0,78,364,1365,4380,12520";
    $bootcoefs{"6C"} = "0,15,-32,87,-192,343";
    $bootcoefs{"6D"} = "0,-2,28,-27,-52,136";
    $bootcoefs{"6E"} = "0,6,4,-3,-12,-8";
    $bootcoefs{"6F"} = "0,0,-8,0,0,28";
    $bootcoefs{"7A"} = "0,51,204,681,1956,5135";
    $bootcoefs{"7B"} = "0,2,8,-5,-4,-10";
    $bootcoefs{"8A"} = "0,36,128,386,1024,2488";
    $bootcoefs{"8B"} = "0,12,0,66,0,232";
    $bootcoefs{"8C"} = "0,0,0,26,0,0";
    $bootcoefs{"8D"} = "0,-4,0,2,0,8";
    $bootcoefs{"8E"} = "0,4,0,2,0,-8";
    $bootcoefs{"8F"} = "0,0,0,-6,0,0";
    $bootcoefs{"9A"} = "0,27,86,243,594,1370";
    $bootcoefs{"9B"} = "0,0,5,0,0,-7";
    $bootcoefs{"10A"} = "0,22,56,177,352,870"; 
    $bootcoefs{"10B"} = "0,6,-8,17,-32,54";
    $bootcoefs{"10C"} = "0,-3,6,2,2,-5";
    $bootcoefs{"10D"} = "0,21,62,162,378,819";
    $bootcoefs{"10E"} = "0,1,2,2,-2,-1";
    $bootcoefs{"11A"} = "0,17,46,116,252,533";
    $bootcoefs{"12A"} = "0,15,32,87,192,343"; 
    $bootcoefs{"12B"} = "0,6,-4,-3,12,-8";
    $bootcoefs{"12C"} = "0,7,0,15,0,71";
    $bootcoefs{"12D"} = "0,0,8,0,0,28";
    $bootcoefs{"12E"} = "0,-1,0,7,0,-9";
    $bootcoefs{"12F"} = "0,6,0,21,0,56";
    $bootcoefs{"12G"} = "0,-2,0,-3,0,8";
    $bootcoefs{"12H"} = "0,14,36,85,180,360";
    $bootcoefs{"12I"} = "0,2,0,1,0,0";
    $bootcoefs{"12J"} = "0,0,0,0,0,-4";
    $bootcoefs{"13A"} = "0,12,28,66,132,258"; 
    $bootcoefs{"13B"} = "0,-1,2,1,2,-2";
    $bootcoefs{"14A"} = "0,11,20,57,92,207";
    $bootcoefs{"14B"} = "0,3,-4,9,-12,15";
    $bootcoefs{"14C"} = "0,10,24,51,100,190";
    $bootcoefs{"15A"} = "0,8,22,42,70,155";
    $bootcoefs{"15B"} = "0,-1,4,-3,-2,11";
    $bootcoefs{"15C"} = "0,9,19,42,78,146";
    $bootcoefs{"15D"} = "0,0,-2,0,0,-1";
    $bootcoefs{"16A"} = "0,4,0,10,0,24";
    $bootcoefs{"16B"} = "0,0,0,2,0,0";
    $bootcoefs{"16C"} = "0,8,16,34,64,112";
    $bootcoefs{"17A"} = "0,7,14,29,50,92";
    $bootcoefs{"18A"} = "0,-2,1,0,2,1";
    $bootcoefs{"18B"} = "0,7,10,27,38,82";
    $bootcoefs{"18C"} = "0,3,-2,3,-6,10";
    $bootcoefs{"18D"} = "0,0,1,0,0,1";
    $bootcoefs{"18E"} = "0,6,13,24,42,73";
    $bootcoefs{"19A"} = "0,6,10,21,36,61";
    $bootcoefs{"20A"} = "0,6,8,17,32,54";
    $bootcoefs{"20B"} = "0,2,0,9,0,10";
    $bootcoefs{"20C"} = "0,1,-2,2,2,-1";
    $bootcoefs{"20D"} = "0,-2,0,1,0,-2";
    $bootcoefs{"20E"} = "0,3,0,6,0,13";
    $bootcoefs{"20F"} = "0,5,10,18,30,51";
    $bootcoefs{"21A"} = "0,6,6,15,30,41";
    $bootcoefs{"21B"} = "0,-1,-1,1,2,-1";
    $bootcoefs{"21C"} = "0,0,3,0,0,8";
    $bootcoefs{"21D"} = "0,5,8,16,26,44";
    $bootcoefs{"22A"} = "0,5,6,16,20,41";
    $bootcoefs{"22B"} = "0,1,-2,4,-4,5";
    $bootcoefs{"23A"} = "0,4,7,13,19,33";
    $bootcoefs{"23B"} = "0,4,7,13,19,33";
    $bootcoefs{"24A"} = "0,3,0,3,0,7";
    $bootcoefs{"24B"} = "0,3,8,11,16,31";
    $bootcoefs{"24C"} = "0,0,2,-1,-2,4";
    $bootcoefs{"24D"} = "0,-1,0,-1,0,-1";
    $bootcoefs{"24E"} = "0,0,0,0,0,4";
    $bootcoefs{"24F"} = "0,0,0,3,0,0";
    $bootcoefs{"24G"} = "0,0,0,-1,0,0";
    $bootcoefs{"24H"} = "0,2,0,5,0,8";
    $bootcoefs{"24I"} = "0,4,6,11,18,28";
    $bootcoefs{"24J"} = "0,0,0,0,0,0";
    $bootcoefs{"25A"} = "0,4,5,10,16,25";
    $bootcoefs{"26A"} = "0,4,4,10,12,26";
    $bootcoefs{"26B"} = "0,3,6,9,14,22";
    $bootcoefs{"27A"} = "0,3,5,9,12,20";
    $bootcoefs{"27B"} = "0,3,5,9,12,20";
    $bootcoefs{"28A"} = "0,3,0,1,0,7";
    $bootcoefs{"28B"} = "0,3,4,9,12,15";
    $bootcoefs{"28C"} = "0,-1,0,1,0,-1";
    $bootcoefs{"28D"} = "0,2,0,3,0,6";
    $bootcoefs{"29A"} = "0,3,4,7,10,17";
    $bootcoefs{"30A"} = "0,3,-1,0,0,0";
    $bootcoefs{"30B"} = "0,4,2,6,10,15";
    $bootcoefs{"30C"} = "0,0,-2,2,-2,3";
    $bootcoefs{"30D"} = "0,3,4,5,10,15";
    $bootcoefs{"30E"} = "0,0,2,0,0,3";
    $bootcoefs{"30F"} = "0,3,3,8,8,16";
    $bootcoefs{"30G"} = "0,1,-1,2,-2,2";
    $bootcoefs{"31A"} = "0,3,3,6,9,13";
    $bootcoefs{"31B"} = "0,3,3,6,9,13";
    $bootcoefs{"32A"} = "0,2,4,6,8,12";
    $bootcoefs{"32B"} = "0,2,0,2,0,4";
    $bootcoefs{"33A"} = "0,-1,1,-1,0,2";
    $bootcoefs{"33B"} = "0,2,4,5,6,14";
    $bootcoefs{"34A"} = "0,3,2,5,6,12";
    $bootcoefs{"35A"} = "0,1,4,6,6,10";
    $bootcoefs{"35B"} = "0,2,3,5,6,10";
    $bootcoefs{"36A"} = "0,3,2,3,6,10";
    $bootcoefs{"36B"} = "0,0,-1,0,0,1";
    $bootcoefs{"36C"} = "0,1,0,3,0,2";
    $bootcoefs{"36D"} = "0,2,3,4,6,9";
    $bootcoefs{"38A"} = "0,2,2,5,4,9";
    $bootcoefs{"39A"} = "0,3,1,3,6,6";
    $bootcoefs{"39B"} = "0,0,1,0,0,3";
    $bootcoefs{"39C"} = "0,2,2,4,5,7";
    $bootcoefs{"39D"} = "0,2,2,4,5,7";
    $bootcoefs{"40A"} = "0,0,0,1,0,0";
    $bootcoefs{"40B"} = "0,2,0,1,0,2";
    $bootcoefs{"40C"} = "0,1,0,2,0,3";
    $bootcoefs{"40D"} = "0,1,0,2,0,3";
    $bootcoefs{"41A"} = "0,2,2,3,4,7";
    $bootcoefs{"42A"} = "0,2,2,3,2,9";
    $bootcoefs{"42B"} = "0,1,0,0,-2,4";
    $bootcoefs{"42C"} = "0,0,-1,0,0,0";
    $bootcoefs{"42D"} = "0,1,3,3,4,7";
    $bootcoefs{"44A"} = "0,1,2,4,4,5";
    $bootcoefs{"44B"} = "0,1,2,4,4,5";
    $bootcoefs{"45A"} = "0,2,1,3,4,5";
    $bootcoefs{"46A"} = "0,0,-1,1,-1,1";
    $bootcoefs{"46B"} = "0,0,-1,1,-1,1";
    $bootcoefs{"46C"} = "0,2,1,3,3,5";
    $bootcoefs{"46D"} = "0,2,1,3,3,5";
    $bootcoefs{"47A"} = "0,1,2,3,3,5";
    $bootcoefs{"47B"} = "0,1,2,3,3,5";
    $bootcoefs{"48A"} = "0,1,0,1,0,3";
    $bootcoefs{"50A"} = "0,2,1,2,2,5";
    $bootcoefs{"51A"} = "0,1,2,2,2,5";
    $bootcoefs{"52A"} = "0,0,0,2,0,2";
    $bootcoefs{"52B"} = "0,1,0,1,0,2";
    $bootcoefs{"54A"} = "0,1,1,3,2,4";
    $bootcoefs{"55A"} = "0,2,1,1,2,3";
    $bootcoefs{"56A"} = "0,1,2,1,2,3";
    $bootcoefs{"56B"} = "0,0,0,1,0,0";
    $bootcoefs{"56C"} = "0,0,0,1,0,0";
    $bootcoefs{"57A"} = "0,0,1,0,0,1";
    $bootcoefs{"59A"} = "0,1,1,2,2,3";
    $bootcoefs{"59B"} = "0,1,1,2,2,3";
    $bootcoefs{"60A"} = "0,2,0,0,0,1";
    $bootcoefs{"60B"} = "0,0,2,2,2,3";
    $bootcoefs{"60C"} = "0,1,1,2,2,2";
    $bootcoefs{"60D"} = "0,-1,1,0,0,0";
    $bootcoefs{"60E"} = "0,1,0,1,0,1";
    $bootcoefs{"60F"} = "0,0,0,0,0,1";
    $bootcoefs{"62A"} = "0,1,1,2,1,3";
    $bootcoefs{"62B"} = "0,1,1,2,1,3";
    $bootcoefs{"66A"} = "0,2,0,1,2,2";
    $bootcoefs{"66B"} = "0,1,1,1,2,2";
    $bootcoefs{"68A"} = "0,1,0,1,0,0";
    $bootcoefs{"69A"} = "0,1,1,1,1,3";
    $bootcoefs{"69B"} = "0,1,1,1,1,3";
    $bootcoefs{"70A"} = "0,1,0,2,2,2";
    $bootcoefs{"70B"} = "0,0,-1,1,0,0";
    $bootcoefs{"71A"} = "0,1,1,1,1,2";
    $bootcoefs{"71B"} = "0,1,1,1,1,2";
    $bootcoefs{"78A"} = "0,1,1,1,0,2";
    $bootcoefs{"78B"} = "0,0,0,0,-1,1";
    $bootcoefs{"78C"} = "0,0,0,0,-1,1";
    $bootcoefs{"84A"} = "0,0,0,1,0,1";
    $bootcoefs{"84B"} = "0,-1,0,0,0,0";
    $bootcoefs{"84C"} = "0,0,1,0,0,0";
    $bootcoefs{"87A"} = "0,0,1,1,1,2";
    $bootcoefs{"87B"} = "0,0,1,1,1,2";
    $bootcoefs{"88A"} = "0,1,0,0,0,1";
    $bootcoefs{"88B"} = "0,1,0,0,0,1";
    $bootcoefs{"92A"} = "0,0,1,1,1,1";
    $bootcoefs{"92B"} = "0,0,1,1,1,1";
    $bootcoefs{"93A"} = "0,0,0,0,0,1";
    $bootcoefs{"93B"} = "0,0,0,0,0,1";
    $bootcoefs{"94A"} = "0,1,0,1,1,1";
    $bootcoefs{"94B"} = "0,1,0,1,1,1";
    $bootcoefs{"95A"} = "0,1,0,1,1,1";
    $bootcoefs{"95B"} = "0,1,0,1,1,1";
    $bootcoefs{"104A"} = "0,0,0,0,0,0";
    $bootcoefs{"104B"} = "0,0,0,0,0,0";
    $bootcoefs{"105A"} = "0,1,1,0,0,1";
    $bootcoefs{"110A"} = "0,0,1,1,0,1";
    $bootcoefs{"119A"} = "0,0,0,1,1,1";
    $bootcoefs{"119B"} = "0,0,0,1,1,1";

my %hash = ();
foreach my $name (@classes) {
    $name =~ m{\A(\d+)([a-zA-Z]+)\Z}; 
    my ($classno, $letters) = ($1, $2);
    my @letters = split(//, $letters);
    foreach my $letter (@letters) {
        $hash{$classno . $letter} = $name;
    }
} # foreach 
    
my $debug = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $step0 = 1;
my $boots = "1,0";
while (<>) {
    next if ! m{\AA\d+}; # if not starting with A-number
    s/\s+\Z//; # chompr
    my $line = $_;
    my ($aseqno, $callcode, $offset, $bfimax, $superclass, $termlist, $name, @rest) = split(/\t/, $line);
    $name =~ m{class (\d+)([a-zA-Z]+)}; 
    my ($classno, $letters) = ($1, $2);
    my $class = "$classno$letters";
    if ($class =~ m{[a-z]}) { # lowercase
        $callcode .= "lc";
    } else { # uppercase
        $class = $hash{$class}; # may have a combination of several letters
    }
    my $with = ($name =~ m{with a\(0\)\s*\=\s*([^\.]*)}) ? $1 : "";
    my @terms = split(/\,/, $termlist); 
    my $newlist = join(",", splice(@terms, 0, 2)); # only 2 prefix terms
    if ($callcode =~ m{\Amckay\Z}) {
    	#                                             PARM1   PARM2     PARM3      PARM4   PARM5
        print join("\t", $aseqno, $callcode, $offset, $class, $letters, $newlist, $step0, $with
                       # PARM6        PARM7      PARM8
                       , $superclass, $termlist, $bootcoefs{$class}) . "\n"; 
    } else {
        print STDERR $line . "\n";
    }
} # while <>
#================================
__DATA__
aseqno  callcode    offset  bfimax superclass termlist
A003295 mckay   -1  1002    A128663 1,-5,17,46,116,252,533,1034 McKay-Thompson series of class 11A for the Monster group with a(0) = -5.
A007191 mckay   -1  5002    EulerTransform  1,-24,276,-2048,11202,-49152,184024,-614400 McKay-Thompson series of class 2B for the Monster group with a(0) = -24.
A007240 mckay   -1  10002   A000521 1,24,196884,21493760,864299970,20245856256,333202640600 McKay-Thompson series of class 1A for the Monster group with a(0) = 24.
A007241 mckay   -1  10002   Sequence    1,24,4372,96256,1240002,10698752,74428120,431529984 McKay-Thompson series of class 2A for the Monster group with a(0) = 24.
A007242 mckay   0   5001    A000521 1,-492,-22590,-367400,-3764865,-28951452,-182474434,-990473160  McKay-Thompson series of class 2a for the Monster group.
A007243 mckay   -1  10002   A030197 1,0,783,8672,65367,371520,1741655,7161696   McKay-Thompson series of class 3A for the Monster group with a(0) = 0.
A007244 mckay   -1  1002    A030182 1,0,54,-76,-243,1188,-1384,-2916    McKay-Thompson series of class 3B for the Monster group.
A007245 mckay   0   10001   Sequence    1,248,4124,34752,213126,1057504,4530744,17333248    McKay-Thompson series of class 3C for the Monster group.
