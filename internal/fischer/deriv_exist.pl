#!perl

# Determine whether the derivating sequences exist
# @(#) $Id$
# 2020-06-15, Georg Fischer
#
#:# Usage:
#:#   perl deriv_exist.pl [-d debug] deriv1.tmp > deriv2.tmp
#:#       reads deriv0.tmp
#-------------------------------------------------
use strict;
use integer;
use warnings;
use Digest::MD5;

my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

my $debug = 0;
if (scalar(@ARGV) < 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
#--------
my ($aseqno, $name, $offset);
my %ders = ();
open (DER, "<", "deriv0.tmp") || die "cannot read deriv0.tmp\n";
while (<DER>) {
    s{\s+\Z}{};
    ($aseqno, $offset) = split(/\t/);
    if ($offset < 0) {
        # skip 
        # $offset = chr(ord('Z') + 1 + $offset);
    } else {
        $ders{$aseqno} = $offset;
    }
} # while <DER>
close(DER);
print STDERR scalar(%ders) . " jOEIS offsets read\n";

while (<>) {
    my $line = $_;
    next if $line !~ m{\AA\d+};
    $line =~ s/\s+\Z//; # chompr
    ($aseqno, $name) = split(/\t/, $line);
    my $ok = 1;
    if ($name =~ m{conjecture|empirical|apparent}i) {
        $ok = -1; # not manifested
    }
    if ($name =~ s{\Aa\(n\) *== *}{}) {
        $ok = -2; # a(n) modulo ...
    }
    $name =~ s{(\A|\W)a\(n\) *= *}{}g; # remove leading "a(n) = "
    $name =~ s{(A\d{6})}{defined($ders{$1}) ? "$1_$ders{$1}" : ("X" . substr($1, 1))}eg; # either X012345 or A012345_offset
    my $cond = "";
    if (0) {
    } elsif ($name =~ s{ *(\, *|\,? *for +|\,? *with +|\,? *where +|\,? *if +) *(.*)\Z}{}) { # with condition
        $cond = $1 || "";
        if ($cond =~ m{\An *([\\=\>]+) *(\d+) *\Z}) {
            my ($op, $dist) = ($1, $2);
            if ($op !~ m{=}) {
                $dist ++;
            }
            $cond = $dist;  
        } else { 
            $ok = -3; # condition not of the form "n >= d"
        }
    } elsif ($name =~ s{ *unless +n *(.*)\Z}{}){
        $cond = $1; 
        if ($cond =~ m{\= *0 *\Z}) {
            $cond = 1; # >= 1
        } else {
            $ok = -4; # condition not of the form "unless n = 0"
        }
    } # with condition
    if (length($cond) > 0) {
        $cond = "n>=$cond";
    }

    # $name =~ s{\A *\((.*)\) *\Z}{$1}; # remove outer parentheses - but "(n+1) - A012345(n)"
    $name =~ tr{\[\]\{\}}
               {\(\)\(\)};
    $name =~ s{ +mod(ulo)? +}{ \% }g; # " mod " -> "%"
    $name =~ s{\(mod *([^\)]+)\)}{\% $1}g; # "(mod d)" -> "% d"
    if ($name =~ s{\|}{abs\(}) { # |...| -> abs(...)
        $name =~ s{\|}{\)};
    }
    $name =~ s{ceiling}{ceil}ig;
    $name =~ s{(\A|\W)prime\(}		{${1}A000040_1\(}ig;
    $name =~ s{(\A|\W)primepi\(}	{${1}A000720_1\(}ig;
    $name =~ s{(\A|\W)sigma\(}		{${1}A000203_1\(}ig;
    $name =~ s{(\A|\W)phi\(}		{${1}A000010_1\(}ig;
    $name =~ s{(\A|\W)psi\(}		{${1}A001615_1\(}ig;
    $name =~ s{(bigomega|Omega)\(}	{A001222_1\(}g;
    $name =~ s{omega\(}				{A001221_1\(}g;
    $name =~ s{Fibonacci\(}			{A000045_0\(}ig;
    $name =~ s{(\A|\W)(d|tau)\(}		{${1}A000005_1\(}g;
    foreach my $part (split(/ *\= */, $name)) {
       if ($part =~ s{[\'\’\xe2\`\´]}{}g) {
           $ok = -5; # apostrophe not allowed
       }
       if ($part =~ m{(\A|\W)(min|max)\(}) {
           $ok = -6; # min, max forbidden
       }
       if ($ok >= 1 and ! defined($ders{$aseqno})) { # not in jOEIS
            #  and ($part !~ m{X\d{6}}) and ($part =~ m{A\d{6}})) {
            while ($part =~ m{(A\d{6}_\d+)\(([^\)]+)\)}) { # replace index
                my ($aseqno_ofs, $index) = ($1, $2);
                my ($sign, $dist);
                if ($index =~ m{\An(([\+\-])(\d+))?\Z}) { 
                    $sign = $2 || "";
                    $dist = $3 || "";
                    if ($sign ne "") {
                        $sign =~ s{\+}{__$dist};
                        $sign =~ s{\-}{_$dist};
                    }
                    $part =~ s{$aseqno_ofs\(([^\)]+)\)}{$aseqno_ofs$sign}; # may not use $index because of embedded "+"
                } else {
                    $ok = -7; # index of Annnnnn is not of the form "n[+-d]"
                    $part =~ s{$aseqno_ofs\(([^\)]+)\)}{$aseqno_ofs\?};
                }
                if ($debug >= 1) {
                    print "# part=\"$part\", aseqno_ofs=\"$aseqno_ofs\", index=\"$index\", sign=\"$sign\", dist=\"$dist\"\n";
                }
            } # while replacing indices
            if ($part =~ m{\w\w +\w\w}) {
                $ok = -8; # words / comments
            }
            if ($part =~ m{(\W|\A)a\(A\d}) {
                $ok = -9; # a(A012345...)
            }
            if ($part =~ m{$aseqno}) {
                $ok = -10; # same A-number as left side
            }
            
            if ($ok >= 1) {
                my $md5 = Digest::MD5->new;
                $md5->add($part);
                print join("\t", $aseqno, $md5->hexdigest, 0, "~~$part", $part, $cond) . "\n"; # substr() = pattern column for seq3
            }
        } # if not in jOEIS
    } # foreach $part
} # while 
__DATA__
deriv0.tmp:
A000001	0
A000002	1
A000003	1
A000004	0
A000005	1
A000006	1
A000007	0

derv1.tmp:
A032033	a(n) = 3*A050352(n), n > 0
A032034	a(n) = 2 * A032188(n)
A032085	a(n) = A005418(n+1)-A016116(n+2), n>1
A032086	a(n) = (3^n - 3^(ceiling(n/2)) / 2 = (A000244(n) - A056449(n)) / 2 for n>1
A032088	a(n) = (5^n - 5^(ceiling(n/2)) / 2 = (A000351(n) - A056451(n)) / 2 for n>1
A032091	a(n) = 2*A002624(n-6) - _Robert G
A032094	a(n) = 4*A031164(n-9)
A032106	a(n) = (1/8)*(2*A000984(n) - (3-(-1)^n)*A000984(floor(n/2)) for n >= 2
A032109	a(n) = (A000670(n)+1)/2
A032120	a(n) = (A000244(n) + A056449(n)) / 2
A032121	a(n) = (4^n + 4^floor((n+1)/2)) / 2 = (A000302(n) + A056450(n)) / 2
A032122	a(n) = 1/2 * (5^n + 5^floor((n+1)/2)) = 5*A001447(n+1)
A032122	a(n) = (A000351(n) + A056451(n)) / 2
