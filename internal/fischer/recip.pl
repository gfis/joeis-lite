#!perl

# recip.pl: A049150 Recip transform of 2*(1 + x^2)-1/(1-x).
# 2021-05-01, Georg Fischer

use strict;
use integer;

my $rseqno = "A049150";
my $callcode = "parm3";
while (<>) {
    s/\s+\Z//; # chompr
    if (m{\A.C (A\d+) Sign diagram of generating sequence\: ([\+\-]+)}) {
        my ($aseqno, $diagram) = ($1, $2);
        $diagram =~ s{\-*\.*\Z}{};
        $diagram =~ s{([\+\-])}{${1}1,}g;
        $diagram .= "-1";
        print join("\t", $aseqno, $callcode, 0, $rseqno, "new long[] { $diagram }", "new long[] { -1 }") . "\n";
    } # if match
} # while
#--------
__DATA__
C:\Users\User\work\gits\OEIS-mat\common>grep -i "Sign diagram" jcat25.txt
%C A049150 Sign diagram of generating sequence: +-+------------...
%C A049151 Sign diagram of generating sequence: +--+-----------...
%C A049152 Sign diagram of generating sequence: +---+----------...
%C A049153 Sign diagram of generating sequence: +-+-+----------...
%C A049154 Sign diagram of generating sequence: +--++----------...
%C A049155 Sign diagram of generating sequence: +----+---------...
%C A049156 Sign diagram of generating sequence: +-+--+---------...
%C A049157 Sign diagram of generating sequence: +--+-+---------...
%C A049158 Sign diagram of generating sequence: +---++---------...
%C A049159 Sign diagram of generating sequence: +--+++---------...
%C A049160 Sign diagram of generating sequence: +-----+--------...
%C A049161 Sign diagram of generating sequence: +-+---+--------...
%C A049162 Sign diagram of generating sequence: +--+--+--------...
%C A049163 Sign diagram of generating sequence: +---+-+--------...
%C A049164 Sign diagram of generating sequence: +-+-+-+--------...
%C A049165 Sign diagram of generating sequence: +--++-+--------...
%C A049166 Sign diagram of generating sequence: +----++--------...
%C A049167 Sign diagram of generating sequence: +-+--++--------...
%C A049168 Sign diagram of generating sequence: +--+-++--------...
%C A049169 Sign diagram of generating sequence: +---+++--------...
%C A049170 Sign diagram of generating sequence: +--++++--------...
#C A049171 Sign diagram of generating sequence: +++-------------...
%C A049172 Sign diagram of generating sequence: +++-+-----------...
%C A049173 Sign diagram of generating sequence: +++++-----------...
%C A049174 Sign diagram of generating sequence: +++--+----------...
%C A049175 Sign diagram of generating sequence: +++-++----------...
%C A049176 Sign diagram of generating sequence: +++---+---------...
%C A049177 Sign diagram of generating sequence: +++-+-+---------...
%C A049178 Sign diagram of generating sequence: +++++-+---------...
%C A049179 Sign diagram of generating sequence: +++--++---------...
%C A049180 Sign diagram of generating sequence: +++-+++---------...
%C A049181 Sign diagram of generating sequence: +++++++---------...
%C A049182 Sign diagram of generating sequence: +++----+--------...
%C A049183 Sign diagram of generating sequence: +++-+--+--------...
%C A049184 Sign diagram of generating sequence: +---++++-+-+-+-+-+-+...
%C A049185 Sign diagram of generating sequence: +++---++--------...
%C A049186 Sign diagram of generating sequence: +++-+-++--------...
%C A049187 Sign diagram of generating sequence: +++++-++--------...
%C A049188 Sign diagram of generating sequence: +++--+++--------...
%C A049189 Sign diagram of generating sequence: +++-++++--------...