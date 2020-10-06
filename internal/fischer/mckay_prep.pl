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
my $limit = 64;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{l}) {
        $limit     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

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
    $termlist = join(",", splice(@terms, 0, 2)); # only 2 prefix terms
    if ($callcode eq "mckay") {
        print join("\t", $aseqno, $callcode, $offset, $class, $letters, $termlist, $with, $superclass) . "\n"; 
    } else {
        print STDERR $line . "\n";
    }
} # while <>
#----
sub get_terms { # split them from the list, and adjust them corresponding to the offset1
    my ($ofs) = @_;
} # get_terms
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
