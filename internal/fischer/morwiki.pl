#!perl

# Extract parameters from https://oeis.org/wiki/Index_to_OEIS:_Section_Fi#FIXEDPOINTS
# @(#) $Id$
# 2021-09-20, Georg Fischer
#
#:# Usage:
#:#   perl morwiki.pl > output.tmp
#---------------------------------
use strict;
use integer;
use warnings;

my $line;
my $aseqno;
my $start;
my $map;
my $cc = "morfps";

while(<DATA>) {
    s{\s+\Z}{}; # chompr
    $line = $_;
    if (0) {
    } elsif ($line =~ m{fixed points of mappings \(Others\)\: (.*)}) {
        my $list = $1;
        foreach $aseqno ($list =~ m{(A\d\d+)}g) {
            print join("\t", $aseqno, $cc, 0, "others") . "\n";
        }
    } elsif ($line =~ m{fixed points of mappings \([^\)]+\)\: *(A\d\d+) *(.*)}) {
    	$aseqno = $1;
        my $map = $2;
        $map =~ s{\, [a-z].*}{};
        $map =~ s{\s}{}g;
        $map =~ s{\{\,}{\{}g;
        while ($map =~ m{\{([^\}]+)\}}) {
            my $inner = $1;
            my $repl  = $inner;
            $repl =~ s{[^\d]}{}g;
            $map =~ s{\{$inner\}}{$repl};
        } # while
        print join("\t", $aseqno, join(" ", $cc, 0, 0, "anchor", $map)) . "\n";
    }
} # while <>
#--------
__DATA__
fixed points of mappings (0): A171588 0 -> {0, 0, 1}, 1 -> {0}
fixed points of mappings (00): A189628 0 -> {0, 0, 1}, 1 -> {0, 1, 0}
fixed points of mappings (01): A006996 0 -> {0, 0, 0}, 1 -> {1, 2, 0}, 2 -> {2, 1, 0}
fixed points of mappings (02): A039969 0 -> {0, 0, 0}, 1 -> {1, 2, 0}, 2 -> {2, 1, 0} then 0 -> {0, 0, 0} 1 -> {1, 1, 1}, 2 -> {2, 2, 2}
fixed points of mappings (02.1): A344893 0 -> {0, 0, 0, 0}, 1 -> {1, 3, 2, 1}, 2 -> {0, 0, 2, 1}, 3 -> {1, 3, 0, 0}
fixed points of mappings (03): A007949 0 -> {0, 0, 1}, 1 -> {0, 0, 2}, 2 -> {0, 0, 3}, 3 -> {0, 0, 4}, etc., a -> {0, 0, a + 1}
fixed points of mappings (04): A003849 0 -> {0, 1}, 1 -> {0}
fixed points of mappings (05): A096268 0 -> {0, 1}, 1 -> {0, 0}
fixed points of mappings (05.1): A284745 0 -> {0, 1}, 1 -> {0, 0, 0}
fixed points of mappings (05.2): A284683 0 -> {0, 1}, 1 -> {0, 0, 0, 0}
fixed points of mappings (05.3): A284751 0 -> {0, 1}, 1 -> {0, 0, 0, 1}
fixed points of mappings (05.4): A284772 0 -> {0, 1}, 1 -> {0, 0, 1, 0}
fixed points of mappings (05.5): A284775 0 -> {0, 1}, 1 -> {0, 0, 1, 1}
fixed points of mappings (05.6): A284851 0 -> {0, 1}, 1 -> {0, 1, 0, 0}
fixed points of mappings (05.7): A284878 0 -> {0, 1}, 1 -> {0, 1, 1, 0}
fixed points of mappings (05.8): A284893 0 -> {0, 1}, 1 -> {0, 1, 1, 1}
fixed points of mappings (05.9): A284901 0 -> {0, 1}, 1 -> {1, 0, 0, 0}
fixed points of mappings (05.10): A284905 0 -> {0, 1}, 1 -> {1, 0, 0, 1}
fixed points of mappings (05.11): A284912 0 -> {0, 1}, 1 -> {1, 0, 1, 0}
fixed points of mappings (05.12): A284929 0 -> {0, 1}, 1 -> {1, 0, 1, 1}
fixed points of mappings (05.13): A284935 0 -> {0, 1}, 1 -> {1, 1, 0, 0}
fixed points of mappings (05.14): A284939 0 -> {0, 1}, 1 -> {1, 1, 0, 1}
fixed points of mappings (05.15): A284944 0 -> {0, 1}, 1 -> {1, 1, 1, 0}
fixed points of mappings (06): A000035 0 -> {0, 1}, 1 -> {0, 1}
fixed points of mappings (07): A096270 0 -> {0, 1}, 1 -> {0, 1, 1}
fixed points of mappings (08): A277731 0 -> {0, 1}, 1 -> {0, 1, 2}, 2 -> {0}
fixed points of mappings (08): A100260 0 -> {0, 1}, 1 -> {0, 2}, 2 -> {3, 1}, 3 -> {3, 2}
fixed points of mappings (09): A080843 0 -> {0, 1}, 1 -> {0, 2}, 2 -> {0}
fixed points of mappings (10): A096271 0 -> {0, 1}, 1 -> {0, 2}, 2 -> {0, 0}
fixed points of mappings (11): A007814 0 -> {0, 1}, 1 -> {0, 2}, 2 -> {0, 3}, 3 -> {0, 4}, etc., a -> {0, a + 1}
fixed points of mappings (12): A101614 0 -> {0, 1}, 1 -> {0, 2}, 2 -> {1, 0}
fixed points of mappings (13): A101659 0 -> {0, 1}, 1 -> {0, 2}, 2 -> {1, 1}
fixed points of mappings (14): A101660 0 -> {0, 1}, 1 -> {0, 2}, 2 -> {1, 2}
fixed points of mappings (15): A101661 0 -> {0, 1}, 1 -> {0, 2}, 2 -> {2, 0}
fixed points of mappings (16): A101662 0 -> {0, 1}, 1 -> {0, 2}, 2 -> {2, 1}
fixed points of mappings (17): A101663 0 -> {0, 1}, 1 -> {0, 2}, 2 -> {2, 2}
fixed points of mappings (18): A010060 0 -> {0, 1}, 1 -> {1, 0}
fixed points of mappings (18.1): A189479 0 -> {0, 1}, 1 -> {1, 0, 1}
fixed points of mappings (18.2): A057985 0 -> {0, 1}, 1 -> {1, 2}, 2 -> {0}, with first term 0
fixed points of mappings (18.3): A287066 0 -> {0, 1}, 1 -> {1, 2}, 2 -> {0}, with first term 1
fixed points of mappings (19): A101664 0 -> {0, 1}, 1 -> {1, 2}, 2 -> {0, 0}
fixed points of mappings (20): A101665 0 -> {0, 1}, 1 -> {1, 2}, 2 -> {0, 2}
fixed points of mappings (21): A101666 0 -> {0, 1}, 1 -> {1, 2}, 2 -> {1, 0}
fixed points of mappings (22): A101667 0 -> {0, 1}, 1 -> {1, 2}, 2 -> {2, 0}
fixed points of mappings (23): A071858 0 -> {0, 1}, 1 -> {1, 2}, 2 -> {2, 0}
fixed points of mappings (24): A000120 0 -> {0, 1}, 1 -> {1, 2}, 2 -> {2, 3}, 3 -> {3, 4}, etc.
fixed points of mappings (24.1): A277735 0 -> {0, 1}, 1 -> {2, 0}, 2 -> {0}
fixed points of mappings (25): A101668 0 -> {0, 1}, 1 -> {2, 0}, 2 -> {0, 0}
fixed points of mappings (26): A101669 0 -> {0, 1}, 1 -> {2, 0}, 2 -> {0, 1}
fixed points of mappings (27): A101670 0 -> {0, 1}, 1 -> {2, 0}, 2 -> {0, 2}
fixed points of mappings (28): A101671 0 -> {0, 1}, 1 -> {2, 0}, 2 -> {1, 0}
fixed points of mappings (29): A101672 0 -> {0, 1}, 1 -> {2, 0}, 2 -> {1, 1}
fixed points of mappings (30): A010872 0 -> {0, 1}, 1 -> {2, 0}, 2 -> {1, 2}
fixed points of mappings (31): A101673 0 -> {0, 1}, 1 -> {2, 0}, 2 -> {2, 0}
fixed points of mappings (32): A101674 0 -> {0, 1}, 1 -> {2, 0}, 2 -> {2, 1}
fixed points of mappings (32.1): A287072 0 -> {0, 1}, 1 -> {2, 1}, 2 -> {0}
fixed points of mappings (33): A112658 0 -> {0, 1), 1 -> {2, 1}, 2 -> {0, 3}, 3 -> {2, 3}
fixed points of mappings (33.1): A287086 0 -> {0, 1), 1 -> {2, 2}, 2 -> {0}
fixed points of mappings (34): A189664 0 -> {0, 1, 0}, 1 -> {0, 0, 1}
fixed points of mappings (34.1): A080846 0 -> {0, 1, 0}, 1 -> {0, 1, 1}
fixed points of mappings (34.2): A189668 0 -> {0, 1, 0}, 1 -> {1, 0, 0}
fixed points of mappings (34.3): A189706 0 -> {0, 1, 1}, 1 -> {0, 0, 1}
fixed points of mappings (34.5): A156595 0 -> {0, 1, 1}, 1 -> {0, 1, 0}
fixed points of mappings (35): A076826 0 -> {0, 1, 2}, 1 -> {1}, 2 -> {2, 1, 0}
fixed points of mappings (36): A053838 0 -> {0, 1, 2}, 1 -> {1, 2, 0}, 2 -> {2, 0, 1}
fixed points of mappings (36): A053838 0 -> {0, 1, 2}, 1 -> {1, 2, 0}, 2 -> {2, 0, 1}
fixed points of mappings (36.1): A287516 0 -> {0, 1, 2}, 1 -> {1, 0, 2}, 2 -> {0, 2, 1}
fixed points of mappings (36.2): A287520 0 -> {0, 1, 2}, 1 -> {1, 0, 2}, 2 -> {1, 2, 0}
fixed points of mappings (36.3): A287524 0 -> {0, 1, 2}, 1 -> {1, 0, 2}, 2 -> {, 2, 0, 1}
fixed points of mappings (36.4): A287528 0 -> {0, 1, 2}, 1 -> {1, 0, 2}, 2 -> {, 2, 1, 0}
fixed points of mappings (36.5): A287411 0 -> {0, 1, 2}, 1 -> {1, 2, 0}, 2 -> {, 0, 2, 1}
fixed points of mappings (36.6): A287418 0 -> {0, 1, 2}, 1 -> {1, 2, 0}, 2 -> {, 1, 0, 2}
fixed points of mappings (36.7): A287438 0 -> {0, 1, 2}, 1 -> {1, 2, 0}, 2 -> {, 2, 1, 0}
fixed points of mappings (36.8): A287443 0 -> {0, 1, 2}, 1 -> {2, 0, 1}, 2 -> {, 0, 2, 1}
fixed points of mappings (36.9): A287447 0 -> {0, 1, 2}, 1 -> {2, 0, 1}, 2 -> {, 1, 0,2}
fixed points of mappings (36.10): A287451 0 -> {0, 1, 2}, 1 -> {2, 0, 1}, 2 -> {1, 2, 0}
fixed points of mappings (36.11): A287455 0 -> {0, 1, 2}, 1 -> {2, 0, 1}, 2 -> {2, 1, 0}
fixed points of mappings (36.12): A287385 0 -> {0, 1, 2}, 1 -> {2, 1, 0}, 2 -> {0, 2, 1}
fixed points of mappings (36.13): A287397 0 -> {0, 1, 2}, 1 -> {2, 1, 0}, 2 -> {1, 0, 2}
fixed points of mappings (36.14): A287401 0 -> {0, 1, 2}, 1 -> {2, 1, 0}, 2 -> {1, 2, 0}
fixed points of mappings (36.15): A287407 0 -> {0, 1, 2}, 1 -> {2, 1, 0}, 2 -> {2, 0, 1}
fixed points of mappings (36.16): A053839 0 -> {0, 1, 2, 3}, 1 -> {1, 2, 3, 0}, 2 -> {2, 3, 0, 1}, 3 -> {3, 0, 1, 2}
fixed points of mappings (36.17): A287556 0 -> {0, 1, 3, 2}, 1 -> {1, 3, 2, 0}, 2 -> {3, 2, 0, 1}, 3 -> {2, 0, 1, 3}
fixed points of mappings (36.18): A287561 0 -> {0, 2, 1, 3}, 1 -> {2, 1, 3, 0}, 2 -> {1, 3, 0, 2}, 3 -> {3, 0, 2, 1}
fixed points of mappings (36.19): A287566 0 -> {0, 2, 3, 1}, 1 -> {2, 3, 1, 0}, 2 -> {3, 1, 0, 2}, 3 -> {1, 0, 2, 3}
fixed points of mappings (36.20): A287571 0 -> {0, 3, 1, 2}, 1 -> {3, 1, 2, 0}, 2 -> {1, 2, 0, 3}, 3 -> {2, 0, 3, 1}
fixed points of mappings (36.21): A287576 0 -> {0, 3, 2, 1}, 1 -> {3, 2, 1, 0}, 2 -> {2, 1, 0, 3}, 3 -> {1, 0, 3, 2}
fixed points of mappings (37): A091297 0 -> {0, 2}, 1 -> {0, 2}, 2 -> {1, 1}
fixed points of mappings (38): A092606 0 -> {0, 2, 1}, 1 -> {0}, 2 -> {0}
fixed points of mappings (39): A000004 0 -> {1}, 1 -> {0, 0}
fixed points of mappings (40): A000012 0 -> {1}, 1 -> {0, 0}
fixed points of mappings (41): A005614 0 -> {1}, 1 -> {1, 0}
fixed points of mappings (41.1): A284680 0 -> {1}, 1 -> {1, 0, 0, 0}
fixed points of mappings (41.2): A284369 0 -> {1}, 1 -> {1, 0, 0, 1}
fixed points of mappings (41.2.5): A080764 0 -> {1}, 1 -> {1, 0, 1}}
fixed points of mappings (41.3): A283963 0 -> {1}, 1 -> {1, 0, 1, 0}
fixed points of mappings (41.4): A283966 0 -> {1}, 1 -> {1, 0, 1, 0, 1}
fixed points of mappings (41.5): A284364 0 -> {1}, 1 -> {1, 0, 1, 0, 1, 0}
fixed points of mappings (42): A284368 0 -> {1}, 1 -> {1, 0, 1, 1}}
fixed points of mappings (43): A080764 0 -> {1}, 1 -> {1, 1, 0}
fixed points of mappings (43.1): A284505 0 -> {1}, 1 -> {1, 1, 0, 0}
fixed points of mappings (43.2): A284386 0 -> {1}, 1 -> {1, 1, 0, 1}
fixed points of mappings (44): A029883 0 -> {1, -1}, 1 -> {1, 0, -1}, -1 -> {0}
fixed points of mappings (45): A096268, A284948 0 -> {1, 0}, 1 -> {0, 0}
fixed points of mappings (45.1): A285345, A285373 0 -> {1, 0}, 1 -> {1,1,0,0}
fixed points of mappings (45.1.1): A285301 0 -> {1, 0}, 1 -> {1,0,0,0}
fixed points of mappings (45.1.2): A285305 0 -> {1, 0}, 1 -> {1,0,0,1}
fixed points of mappings (45.1.3): A285341 0 -> {1, 0}, 1 -> {1,0,1,1}
fixed points of mappings (45.1.4): A285345 0 -> {1, 0}, 1 -> {1,1,0,0}
fixed points of mappings (45.1.5): A285358 0 -> {1, 0}, 1 -> {1,1,0,1}
fixed points of mappings (45.1.6): A285373 0 -> {1, 0}, 1 -> {1,1,1,0}
fixed points of mappings (45.1.7): A287104 0 -> {1, 0}, 1 -> {1,2}, 2 -> {0}
fixed points of mappings (45.2): A285177 0 -> {1, 1}, 1 -> {0, 0, 1}
fixed points of mappings (46): A285383 0 -> {1, 1}, 1 -> {0, 1}
fixed points of mappings (46.1): A035263, A285384 0 -> {1, 1}, 1 -> {1, 0}
fixed points of mappings (46.1.1): A287356 0 -> {1, 1}, 1 -> {1, 2}, 2 -> {0}
fixed points of mappings (46.2): A285427 0 -> {1, 1}, 1 -> {1,0,0}
fixed points of mappings (46.3): A285430 0 -> {1, 1}, 1 -> {1,0,1}
fixed points of mappings (46.4): A285431 0 -> {1, 1}, 1 -> {1,1,0}
fixed points of mappings (46.5): A285617 0 -> {1, 1}, 1 -> {1,0,0,0}
fixed points of mappings (46.6): A285621 0 -> {1, 1}, 1 -> {1,0,0,1}
fixed points of mappings (46.7): A285625 0 -> {1, 1}, 1 -> {1,0,1,0}
fixed points of mappings (46.8): A285657 0 -> {1, 1}, 1 -> {1,0,1,1}
fixed points of mappings (46.9): A285661 0 -> {1, 1}, 1 -> {1,1,0,0}
fixed points of mappings (46.10): A285668 0 -> {1, 1}, 1 -> {1,1,0,1}
fixed points of mappings (46.11): A285671 0 -> {1, 1}, 1 -> {1,1,1,0}
fixed points of mappings (47): A092412 0 -> {1, 1}, 1 -> {1, 2}, 2 -> {1, 3}, 3 -> {1, 0}
fixed points of mappings (48): A014578 0 -> {1, 1, 1}, 1 -> {1, 1, 0}
fixed points of mappings (49): A089650 0 -> {1, 1, 1}, 1 -> {1, 2, 0}, 2 -> {1, 0, 2}
fixed points of mappings (50): A089652 0 -> {1, 1, 1, 1}, 1 -> {1, 2, 3, 0}, 2 -> {1, 3, 1, 3}, 3 -> {1, 0, 3, 2}
fixed points of mappings (51): A051064 1 -> {1, 1, 2}, 2 -> {1, 1, 3}, 3 -> {1, 1, 4}, 4 -> {1, 1, 5}, etc.
fixed points of mappings (52): A092400 1 -> {1, 1, 2, 1, 2, 1, 1}, 2 -> {1, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 1}
fixed points of mappings (53): A003842 1 -> {1, 2}, 2 -> {1}
fixed points of mappings (54): A056832 1 -> {1, 2}, 2 -> {1, 1}
fixed points of mappings (55): A102005 1 -> {1, 2}, 2 -> {1, 1, 1}
fixed points of mappings (56): A007001 1 -> {1, 2}, 2 -> {1, 2, 3}, 3 -> {1, 2, 3, 4}, etc., a -> {1,..., a+1}
fixed points of mappings (57): A092782 1 -> {1, 2}, 2 -> {1, 3}, 3 -> {1}
fixed points of mappings (58): A103269 1 -> {1, 2}, 2 -> {1, 3}, 3 -> {1}
fixed points of mappings (59): A001511 1 -> {1, 2}, 2 -> {1, 3}, 3 -> {1, 4}, 4 -> {1, 5}, etc.
fixed points of mappings (60): A105498 1 -> {1, 2}, 2 -> {1, 4}, 3 -> {3, 4}, 4 -> {3, 4}
fixed points of mappings (61): A001285 1 -> {1, 2}, 2 -> {2, 1}
fixed points of mappings (62): A001316 1 -> {1, 2}, 2 -> {2, 4}, 4 -> {4, 8}, 8 -> {8, 16}, etc., a -> {a, 2a}
fixed points of mappings (63): A100619 1 -> {1, 2}, 2 -> {3, 1}, 3 -> {1}
fixed points of mappings (64): A010882 1 -> {1, 2}, 2 -> {3, 1}, 3 -> {2, 3}
fixed points of mappings (65): A105500 1 -> {1, 2}, 2 -> {3, 2}, 3 -> {3, 4}, 4 -> {1, 4}
fixed points of mappings (66): A060236 1 -> {1, 2, 1}, 2 -> {1, 2, 2}
fixed points of mappings (67): A105203 1 -> {1, 2, 1}, 2 -> {2, 3, 2}, 3 -> {3, 1, 3}
fixed points of mappings (68): A105646 1 -> {1, 2, 1}, 2 -> {3, 4, 3}, 3 -> {4, 3, 4}, 4 -> {2, 1, 2}
fixed points of mappings (69): A106825 1 -> {1, 2, 2, 2}, 2 -> {2, 1, 1, 1}
fixed points of mappings (70): A105969 1 -> {1, 2, 3}, 2 -> {2, 1, 2}, 3 -> {3, 4, 5}, 4 -> {4, 3, 4}, 5 -> {5, 6, 1}, 6 -> {6, 5, 6}
fixed points of mappings (71): A026600 1 -> {1, 2, 3}, 2 -> {2, 3, 1}, 3 -> {3, 1, 2}
fixed points of mappings (72): A057215 1 -> {1, 2, 3}, 2 -> {2, 3, 1}, 3 -> {3, 1, 2} then 1 -> {0, 1}, 2 -> {1, 0}, 3 -> {0, 1}
fixed points of mappings (73): A105789 1 -> {1, 2, 3, 2, 1}, 2 -> {4, 3, 2, 3, 4}, 3 -> {2, 1, 4, 1, 2}, 4 -> {3, 4, 1, 4, 3}
fixed points of mappings (74): A106824 1 -> {1, 3}, 2 -> {1, 3, 2, 2, 3}, 3 -> {1, 3, 2, 3}
fixed points of mappings (75): A080757 1 -> {2, 1}, 2 -> {2, 1, 1}
fixed points of mappings (75a): A014675 1 -> {2}, 2 -> {2, 1}
fixed points of mappings (76): A106826 1 -> {2, 1}, 2 -> {2, 3}, 3 -> {4, 3}, 4 -> {4, 1}
fixed points of mappings (77): A105499 1 -> {2, 1, 2}, 2 -> {1, 3, 1}, 3 -> {3, 2, 3}
fixed points of mappings (78): A102668 1 -> {3}, 2 -> {1}, 3 -> {2, 1, 2}
fixed points of mappings (79): A105584 1 -> {3, 4}, 2 -> {2, 3}, 3 -> {1, 2}, 4 -> {1, 4}
fixed points of mappings (80): A092444 a -> {a, b}, b -> {c, c}, c -> {a, b}, a -> {1}, b -> {1}, c -> {0}
fixed points of mappings (81): A038190 a -> {a, b}, b -> {a, d}, c -> {c, b}, d -> {c, d} a -> {2, 2, 0, 1}, b -> {0, 2, 1, 1}, c -> {0, 2, 2, 1}, d -> {1, 2, 0, 1}
fixed points of mappings (82): A001316 a -> {a, 2a}
fixed points of mappings (83): A038573 a -> {a, 2a + 1}
fixed points of mappings (84): A006047 a -> {a, 2a, 3a}
fixed points of mappings (85): A048883 a -> {a, 3a}
fixed points of mappings (Others): A005679, A036578, A036581, A039966, A059835, A103682, A105083, A105220, A105239, A105258
fixed points of mappings (Others): A105777, A105778, A105791, A106035, A106036, A106052, A106054, A106560, A106590, A106751
fixed points of mappings (Others): A106802, A107789, A108133, A131213, A133162, A162696, A179542, A188082, A214332, A214333
fixed points of mappings (Others): A229215, A229830, A245187, A245553, A245554, A245555, A269723, A272729, A274950, A275925
fixed points of mappings (Others): A276397