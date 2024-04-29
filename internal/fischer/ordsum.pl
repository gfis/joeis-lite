#!perl

# Generate for "number of ways to write n as an ordered sum of COUNT PROPERTY"
# @(#) $Id$
# 2024-04-28, Georg Fischer
#
#:# Usage:
#:#   perl gen_linrec.pl [-d debug] [-n namesfile] infile > outfile
#:#       infile has the format: A-number tab signature space initerms space termno
#:#       signature is not (yet) reversed, comma separated, no spaces
#:#       at most 16 terms are output, and the last term must be shorter than 17 chars.
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);
my $debug = 0;
if (scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $basedir   = "../../../OEIS-mat/common";
my $stripped = "$basedir/stripped"; 
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{n}) {
        $stripped = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

# print `head -n16 $namesfile`;    
my $line;
my ($aseqno, $callcode, $expon, $terms);
my ($rseqno, $rest);

while (<>) {
    s/\s+\Z//; # chompr
    $line = $_;
    ($aseqno, $callcode, $expon, $terms) = split(/\t/, $line);
    my $cmd = "grep \"$terms\" $stripped";
    my @result = split(/\r?\n/, `$cmd`);
    if (scalar(@result) == 0) {
        print "# " . join("\t", $aseqno, $expon, $terms) . "\n";
    } else {
        foreach my $line (@result) {
            ($rseqno, $rest) = split(/ /, $line, 2);
            print join("\t", $rseqno, "ordsum", 0, "new $aseqno()", $expon) . "\n";
        } # foreach
    }
} # while <>
__DATA__
A036987	rstest	8	1,8,28,64,126,224,336,464,645,840,1044,1344,1666,1904,2192,2528,2730,3024,3528,3920,4284,4768,5168,5488,5965,6552,7140,7616,7834,8176,8400,8352
A036987	rstest	9	1,9,36,93,198,378,624,927,1341,1849,2412,3159,4074,4950,5904,7032,8010,9018,10488,11970,13356,15108,16848,18315,20085,22257,24444,26671,28674,30510,32208,33282
A036987	rstest	10	1,10,45,130,300,612,1095,1750,2655,3850,5281,7110,9460,12060,14940,18352,21850,25380,29790,34740,39672,45480,51885,57870,64375,72090,80145,88630,97660,106380,114736,122260
A064911	rstest	2	1,0,0,2,0,2,1,0,4,2,1,2,2,4,4,0,3,4,3,2,2,4,4,4,4,4,3,4,5,6,4,0
A064911	rstest	3	1,0,0,3,0,3,3,0,9,4,3,9,6,12,12,4,15,18,12,15,12,21,24,18,19,24,27,28,27,30,33,27
A064911	rstest	4	1,0,0,4,0,4,6,0,16,8,6,24,13,28,32,16,48,52,38,60,53,76,94,68,90,112,120,128,124,144,176,168
A064911	rstest	5	1,0,0,5,0,5,10,0,25,15,10,50,25,55,75,41,120,125,100,180,165,220,290,225,325,401,405,480,485,575,710,700
A064911	rstest	6	1,0,0,6,0,6,15,0,36,26,15,90,45,96,156,86,255,270,226,450,417,546,765,636,952,1182,1170,1520,1602,1896,2386,2400
