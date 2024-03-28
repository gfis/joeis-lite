#!perl

# Generate polygonal sequences for shapes >= 11
# @(#) $Id$
# 2024-03-28, Georg Fischer; *WK=77

use strict;
use integer;

while(<DATA>) {
    if (m{(A\d+)\s+(\d+)}) {
        my ($aseqno, $shape) = ($1, $2);
        if ($shape % 2 == 1) {
            print join("\t", $aseqno, "polygonod", 0, $shape, ($shape - 2)/1, ($shape - 4)/1) . "\n";
        } else {
            print join("\t", $aseqno, "polygonev", 0, $shape, ($shape - 2)/2, ($shape - 4)/2) . "\n";
        }
    }
}
__DATA__
A051682	11
A051624	12
A051865	13
A051866	14
A051867	15
A051868	16
A051869	17
A051870	18
A051871	19
A051872	20
A051873	21
A051874	22
A051875	23
A051876	24
A256645	25
A255185	26
A255186	27
A161935	28
A255187	29
A254474	30
A098923	33
A282854	34
A282851	35
A282853	36
A282852	37
A282850	38
A261191	40
A098924	45
A095311	47
A261343	50
A249911	60
A098140	63
A098230	75
A261276	100