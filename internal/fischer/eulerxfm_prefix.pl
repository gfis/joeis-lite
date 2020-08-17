#!perl
# Correct the initial terms of eulerxfm
# 2020-08-16, Georg Fischer
use strict;
use warnings;
use integer;

my  ($aseqno, $pos, $fail, $expected, $dummy, $computed, $prefix);
    
while (<>) {
    s/\s+\Z//; # chompr
    next if ! m{\AA\d+\t};
    ($aseqno, $pos, $fail, $expected, $dummy, $computed) = split(/\t/, $_);
    $prefix = &test(1, $computed, $expected); 
    if (length($prefix) > 0) { # $computed has an invalid prefix 1
        $prefix = ""; # remove it
        print "UPDATE seq4 SET parm1 = \'$prefix\' WHERE aseqno = \'$aseqno\'; -- $expected <- $computed\n";
    } else { # $expected has some prefix
        my $len = 0; 
        my $busy = 1;
        while ($busy == 1 and $len <= 5) {
            $prefix = &test($len, $expected, $computed);
            if ($prefix ne "") { 
                $busy = 0;
            }
            $len ++;
        } # while busy
        if ($busy == 0) {
            print "UPDATE seq4 SET parm1 = \'$prefix\' WHERE aseqno = \'$aseqno\'; -- $expected -> $computed\n";
        } else {
            print "-- $aseqno: $expected ? $computed\n";
        }
    } # $expected has some prefix
} # DATA
#----
sub test {
    my ($eshift, $expected, $computed) = @_; # 
    my $exp = $expected;
    my $result = "";
    while ($eshift > 0) {
        $exp =~ s{\A\,(\-?\d+)}{};
        $result .= ", $1";
        $eshift --;
    } # while exp
    if (index($computed, $exp) == 0) {
        $result .= ", 1"
    } else {
        $result = ""; # failure
    }
    return $result;
} # test
#--------
__DATA__
A028724 8   FAIL    ,0,0,0,0,1,2,6,9    computed:   ,1,2,6,9,18,24,40,50
A030218 8   FAIL    ,0,1,0,0,-1,0,-1,-2 computed:   ,1,0,0,-1,0,-1,-2,0
A034828 8   FAIL    ,0,0,1,3,8,15,27,42 computed:   ,1,3,8,15,27,42,64,90
A035175 9   FAIL    ,2,1,3,1,2,0,4,1    computed:   ,1,2,1,3,1,2,0,4
A035362 11  FAIL    ,2,3,3,3,5,7,8,8    computed:   ,1,2,3,3,3,5,7,8
A035364 8   FAIL    ,0,0,1,1,0,1,2,2    computed:   ,1,0,0,1,1,0,1,2
A035365 9   FAIL    ,2,2,3,4,6,7,9,11   computed:   ,1,2,2,3,4,6,7,9
A035366 8   FAIL    ,0,1,1,1,1,3,2,3    computed:   ,1,0,1,1,1,1,3,2
A035367 12  FAIL    ,2,3,3,3,3,5,7,8    computed:   ,1,2,3,3,3,3,5,7
A035368 8   FAIL    ,0,1,0,1,1,1,2,1    computed:   ,1,0,1,0,1,1,1,2
A035369 8   FAIL    ,0,0,1,0,1,1,0,2    computed:   ,1,0,0,1,0,1,1,0
A035370 8   FAIL    ,0,0,0,1,1,0,0,1    computed:   ,1,0,0,0,1,1,0,0
A035372 10  FAIL    ,2,2,2,4,4,5,7,7    computed:   ,1,2,2,2,4,4,5,7
