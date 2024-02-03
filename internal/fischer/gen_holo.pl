#!perl

# Generate a recurrence expression from jcat25.txt
# @(#) $Id$ 
# 2023-12-03, Georg Fischer; *SP=47

use strict;
use integer;
my $state = 0;
my ($line, $aseqno, $inits, $form, $offset, $dist);
$form = "";
$dist = 0;
while(<>) {
    s/\s+\Z//; # chompr;
    $line = substr($_, 3);
    $aseqno = substr($line, 0, 7);
    $line = substr($line, 8);
    if (0) {
    } elsif ($state == 0) {
        if ($line =~ m{remember}) { # state 0: look for "remember", extract $inits from "[...]"
            $line =~ m{\[([^\]]+)};
            $inits = $1;
            $inits =~ s{ }{}g;
            $state = 1;
        }
    } elsif ($state == 1) { # state 1: look for "end", extract $form
        $line =~ s{ }{}g;
        if ($line =~ s{end.*}{}) {
            $form .= $line;
            $state = 2;
        } else {
            $form .= $line;
        }
    } elsif ($state == 2) { # state 2: look for "seq", extract $dist and $offset
        if(0) {
        } elsif ($line =~ m{b\(n\-(\d+)\)\)\: *\!}) {
            $dist = $1;
        } elsif ($line =~ m{seq *\( *a *\( *n *\) *\, *n\ *\= *(\d+) *\.\.}) {
            $offset = $1;
            if (0) {
            } elsif ($form =~ m{a\(n\)}) {
                # leave "a(n)" unchanged
            } elsif ($form =~ s{\/(.*)}{}) { # with dividend
                my $num = $1;
                $num =~ s{\)\Z}{};
                $form = "-a(n)*$num+$form=0"; # place dividend in front
            } else { # prefix with "-a(n)+"
                $form = "-a(n)+$form=0";
            }
            print join("\t", $aseqno, "bva", $offset, $form, $inits, $dist, 0) ."\n";
            $form = "";
            $dist = 0;
            $state = 0;
        }
    }
} # while <DATA>
__DATA__
%p A208616 a:= proc(n) option remember; `if`(n<5, [1, 1, 10, 53, 491][n+1],
%p A208616       ((116013096898*n^6 -1106227006064*n^5 +3651730072724*n^4
%p A208616       -5019246600372*n^3 +2923780805838*n^2 -701199942904*n) *a(n-1)
%p A208616       +(-429126244301*n^6 +4283495440027*n^5 -14793057372915*n^4
%p A208616       +19089754215809*n^3 -168467698444*n^2 -17547244920336*n
%p A208616       +9564646580160) *a(n-2) +(24700698282*n^6 +2323122442728*n^5
%p A208616       -31157649402714*n^4 +153639646198428*n^3 -363480023453028*n^2
%p A208616       +415894667210784*n -184360926114960) *a(n-3) +(292122384552*n^6
%p A208616       -5522876986500*n^5 +42303228071580*n^4 -167574646102140*n^3
%p A208616       +360649174254588*n^2 -397826818736400*n +174796279534800) *a(n-4))/
%p A208616       (n*(3709935431*n^5 -22486109809*n^4 +4251368675*n^3 +135507711725*n^2
%p A208616       -75536091046*n -180596388856)))
%p A208616     end:
%p A208616 seq(a(n), n=0..30);

%p A213873 a:= proc(n) option remember; `if`(n<2, [1, 6][n+1], 
%p A213873       (6*n-9) *(3*n-4)*(3*n-5) *(797*n^4-72*n^3-397*n^2+108*n-4) *a(n-1) / ((n+1)
%p A213873       *(n+2) *(2*n+1) *(797*n^4-3260*n^3+4601*n^2-2502*n+360)))
%p A213873     end:
%p A213873 seq(a(n), n=0..20);
%Y A213873 Column k=3 of €213275.

%p A214159 a:= proc(n) option remember; `if`(n<3, [1, 0, 1][n+1],
%
