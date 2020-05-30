#!perl

# Decide between first and subsequent callcodes tile1, tile6
# 2020-05-30: revised logic
# 2020-05-19, Georg Fischer
#
#:# Usage:
#:#   perl tile_collect.pl tile.tmp > tile.gen
#--------------------------------------------------------
use strict;
use integer;
use warnings;

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

my $ogal    = ""; # old galid
my $buffer1 = "";
my $buffer6 = "";
my $aseqn1;
my $tilen1;
my ($aseqno, $callcode, $offset, $ngalid, $stdnot, $vertexid, $tarots, $tilingno);
while (<>) {
    s{\s+\Z}{}; # chompr
    my $line = $_;
    # $(DBAT) -x "SELECT c.aseqno, 'tile1', 0, c.galid, c.stdnot, c.vtype, c.tarots, c.tilingno 
    ($aseqno, $callcode, $offset, $ngalid, $stdnot, $vertexid, $tarots, $tilingno) = split(/\t/, $line);
    $ngalid =~ m{(Gal\.\d+\.\d+)\.(\d+)};
    my $ngal = $1;
    my $vid  = $2;
    if ($ogal ne $ngal) { # start of new tiling Gal.u.t.v with v=1
        if ($ogal ne "") {
            &output();
        }
        $ogal = $ngal;
        $aseqn1 = $aseqno;
        $tilen1 = $tilingno;
    } # start of new tiling
    $buffer1 .= "~~$vertexid;$tarots";
    if ($vid gt "1") {
        $buffer6 .= join("\t", $aseqno, $callcode, $offset, "\$(PARM)"    , 0      , $vid - 1, $ngalid, $tilingno) . "\n";
    } # vid > 1
} # while <>
if ($ogal ne "") {
   &output();
}
#----
sub output {
    $buffer1 = substr($buffer1, 2); # remove initial "~~"
    print join("\t", $aseqn1, $callcode, $offset, $buffer1, 0, 0, "$ogal.1", $tilen1) . "\n";
    $buffer6 =~ s{\$\(PARM\)}{$buffer1}g;
    print $buffer6;
    $buffer1 = "";
    $buffer6 = "";
} # output
__DATA__
A250120 tile    0   Gal.1.10.1  3.3.3.3.6   6.3.3.3.3   A60+,A300+,A180+,A120+,A240+
A008458 tile    0   Gal.1.11.1  3.3.3.3.3.3 3.3.3.3.3.3 A0+,A0+,A0+,A0+,A0+,A0+
A265035 tile    0   Gal.2.1.1   3.4.6.4;4.6.12  12.6.4  A180-,A120-,B90+
A265036 tile    0   Gal.2.1.2   3.4.6.4;4.6.12  6.4.3.4 A270+,A210-,B120+,B240+
A301287 tile    0   Gal.2.2.1   3.4.3.12;3.12.12    12.12.3 B30+,A180+,B120+
A301289 tile    0   Gal.2.2.2   3.4.3.12;3.12.12    12.3.4.3    A240+,A330+,B90+,B270+
