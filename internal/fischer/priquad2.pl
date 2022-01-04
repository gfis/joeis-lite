#!perl

# priquad2.pl - extract parameters of the MMA program QuadPrimes2[]
# 2022-01-03, Georg Fischer
#
#:# Usage:
#:#     grep -i prime jcat25.txt | grep mod | cut -b4- \
#:#     | perl priquad2.pl > output.seq4
#-----------------------------------------------
use strict;
use integer;

my ($line, $aseqno, $catype, $callcode, $name, $ok, $polar, $discr, @parms);
$callcode = "priquad2";
while (<>) {
# while (<DATA>) {
    $line = $_;
    $line =~ s{\s+\Z}{}; # chompr
    $line =~ s{ *\(\*.*}{}; # remove trailing comment
    $ok   = 0; # assume failure
    $line =~ m{\A(..) (A\d+) +(.*)};
    ($catype, $aseqno, $name) = ($1, $2, $3);
    $polar = 1; # number of Union[] components
    my @parms = ($name =~ m{QuadPrimes2\[([^\]]+)\]}g);
    if (0) {
    } elsif (scalar(@parms) == 1) {
        @parms = split(/\, */, $parms[0]);
        @parms = splice(@parms, 0, 3);
        $ok = 1;
    } elsif (scalar(@parms) == 2) {
        @parms = (split(/\, */, $parms[0]), split(/\, */, $parms[1]));
        if ($parms[0] == $parms[4] && $parms[2] == $parms[6] && $parms[1] == - $parms[5]) {
            $polar = 2;
            @parms = splice(@parms, 0, 3);
            $ok = 1;
        } else {
            print "# no proper union: $line\n";
        }
    } else {
        print "# no call of QuadPrimes2 found: $line\n";
    }
    if ($ok > 0) {
        # A binary quadratic form ax^2+bxy+cy^2 has discriminant d = b^2-4ac.
        $discr = $parms[1] * $parms[1] - 4 * $parms[0] * $parms[2];
        print join("\t", $aseqno, $callcode, 0, $discr, $polar, @parms, "", substr($line, 11)) . "\n";
    }
} # while <>
__DATA__
%t A139906 Union[QuadPrimes2[17, 12, 17, 10000], QuadPrimes2[17, -12, 17, 10000]] (* see A106856 *)
%t A139907 QuadPrimes2[2, -2, 137, 10000] (* see A106856 *)
%t A139908 QuadPrimes2[3, 0, 91, 10000] (* see A106856 *)
%t A139909 QuadPrimes2[6, -6, 47, 10000] (* see A106856 *)
%t A139910 QuadPrimes2[7, 0, 39, 10000] (* see A106856 *)
%t A139911 QuadPrimes2[13, 0, 21, 10000] (* see A106856 *)