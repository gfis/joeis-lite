#!perl

# Decide between first and subsequent callcodes tile1, tile6
# 2020-05-19, Georg Fischer
#
#:# Usage:
#:#   perl tile_collect.pl tile.tmp > tile.gen
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $ogal = ""; # old galid
my $buffer1 = "";
my $buffer6 = "";
my $aseqn1;
while (<DATA>) {
    s{\s+\Z}{}; # chompr
    my $line = $_;
    my ($aseqno, $callcode, $offset, $ngalid, $vertexid, $tarots) = split(/\t/, $line);
    $ngalid =~ m{(Gal\.\d+\.\d+)\.(\d+)};
    my $ngal = $1;
    my $vid = $2;
    if ($ogal ne $ngal) { # start of new tiling Gal.u.t.v with v=1
        if ($ogal ne "") {
            &output();
        }
        $ogal = $ngal;
        $aseqn1 = $aseqno;
    } # start of new tiling
    $buffer1 .= "~~$vertexid;$tarots";
    if ($vid gt "1") {
        $buffer6 .= join("\t", $aseqno, "tile6", 0, &aseq($aseqn1), $aseqn1, $vid, $ngalid) . "\n";
    } # vid > 1
} # while <>
if ($ogal ne "") {
   &output();
}
#----
sub aseq {
    my ($aseqno) = @_;
    return lc(substr($aseqno, 0, 4));
} # package
#----
sub output {
    print join("\t", $aseqn1, 'tile1', 0, substr($buffer1, 2), 1, "$ogal.1") . "\n";
    print $buffer6;
    $buffer1 = "";
    $buffer6 = "";
} # output
__DATA__
A314259	tile	0	Gal.3.60.1	6.3.3.3.3	A60+,A300+,B300+,C0+,B0+
A315529	tile	0	Gal.3.60.2	3.3.3.3.3.3	C60+,A60+,A0+,C0+,B180+,C180+
A315435	tile	0	Gal.3.60.3	3.3.3.3.3.3	B0+,A0+,B300+,C120+,C240+,B180+
A313764	tile	0	Gal.3.61.1	6.3.3.3.3	A180-,B300+,A180+,B120+,C0+
A315039	tile	0	Gal.3.61.2	6.3.3.3.3	A60+,A60-,A240-,C60+,A240+
A315935	tile	0	Gal.3.61.3	3.3.3.3.3.3	B300+,A180-,A0+,B120+,A0-,A180+
A310058	tile	0	Gal.4.1.1	6.6.6	A180-,A60-,B300+
A310182	tile	0	Gal.4.1.2	6.6.6	A60-,A60+,C300+
A310960	tile	0	Gal.4.1.3	6.6.3.3	C300+,B60+,C60+,D120+
A315780	tile	0	Gal.4.1.4	3.3.3.3.3.3	C240+,C300+,C0+,C60+,C120+,C180+
A310104	tile	0	Gal.4.2.1	6.6.6	A60+,A300+,B300+
A310279	tile	0	Gal.4.2.2	6.6.6	C60+,A60+,C180-
A310702	tile	0	Gal.4.2.3	6.6.3.3	C180-,B300+,C300-,D0+
A315786	tile	0	Gal.4.2.4	3.3.3.3.3.3	C240+,C180-,C0+,C300-,C120+,C60-
A310237	tile	0	Gal.4.3.1	6.6.6	A180-,A180+,B300+
A310740	tile	0	Gal.4.3.2	6.6.3.3	C180-,A60+,B300-,D240+
A311044	tile	0	Gal.4.3.3	6.4.4.3	B180-,C60-,C240-,D300-
A314409	tile	0	Gal.4.3.4	4.4.3.3.3	C240+,D180+,C300-,B120+,B60-
