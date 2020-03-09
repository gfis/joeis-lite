#!perl

# Extract parameters for jOEIS
# 2020-03-07, Georg Fischer
#
#:# Usage:
#:#   perl logmod.pl 
#:# Calls clip_maple.pl and generates a lot of files
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $basedir   = "../../../OEIS-mat/common";
while (<DATA>) {
    my $line = $_;
    if ($line =~ m{\A(A\d+)\D+(\d+)\D+(\d+)}) {
        my $aseqno = $1;
        my $base   = $2;
        my $mod    = $3;
        my $count  = $mod - 1;
        my $filename = "clip.tmp";
        open(OUT, ">", $filename) || die "cannot write to \"$filename\"";
        print OUT "with (numtheory): seq(mlog(n, $base, $mod), n=1..$count); # ~~~~\n";
        close(OUT);
        print `perl $basedir/maple.pl -o 1 -s $aseqno $filename`;
        print STDERR "logmod.pl: $aseqno generated\n";
    }
    # last;
} # while <DATA>
__DATA__
A036181 null    Log base 2 (n) mod 101. nonn,fini,synth 1
A036182 null    Log base 5 (n) mod 103. nonn,fini,synth 1
A036183 null    Log base 2 (n) mod 107. nonn,fini,synth 1
A036184 null    Log base 6 (n) mod 109. nonn,fini,synth 1
A036185 null    Log base 3 (n) mod 113. nonn,fini,synth 1
A036186 null    Log base 3 (n) mod 127. nonn,fini,synth 1
A036187 null    Log base 2 (n) mod 131. nonn,fini,synth 1
A036188 null    Log base 3 (n) mod 137. nonn,fini,synth 1
A036189 null    Log base 2 (n) mod 139. nonn,fini,synth 1
A036190 null    Log base 2 (n) mod 149. nonn,fini,synth 1
A036191 null    Log base 6 (n) mod 151. nonn,fini,synth 1
A036192 null    Log base 5 (n) mod 157. nonn,fini,synth 1
A036193 null    Log base 2 (n) mod 163. nonn,fini,synth 1
A036194 null    Log base 5 (n) mod 167. nonn,fini,synth 1
A036195 null    Log base 2 (n) mod 173. nonn,fini,synth 1
A036196 null    Log base 2 (n) mod 179. nonn,fini,synth 1
A036197 null    Log base 2 (n) mod 181. nonn,fini,synth 1
A036198 null    Log base 19 (n) mod 191.    nonn,fini,synth 1
A036199 null    Log base 5 (n) mod 193. nonn,fini,synth 1
A036200 null    Log base 2 (n) mod 197. nonn,fini,synth 1
A036201 null    Log base 3 (n) mod 199. nonn,fini,synth 1
A036202 null    Log base 2 (n) mod 211. nonn,fini,synth 1
A036203 null    Log base 3 (n) mod 223. nonn,fini,synth 1
A036204 null    Log base 2 (n) mod 227. nonn,fini,synth 1
A036205 null    Log base 6 (n) mod 229. nonn,fini,synth 1
A036206 null    Log base 3 (n) mod 233. nonn,fini,synth 1
A036207 null    Log base 7 (n) mod 239. nonn,fini,synth 1
A036208 null    Log base 7 (n) mod 241. nonn,fini,synth 1
A036209 null    Log base 6 (n) mod 251. nonn,fini,synth 1
A036210 null    Log base 3 (n) mod 257. nonn,fini,synth 1
