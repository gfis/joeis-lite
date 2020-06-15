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

my ($aseqno, $name, $offset);
my %ders = ();
open (DER, "<", "deriv0.tmp") || die "cannot read deriv0.tmp\n";
while (<DER>) {
    s{\s+\Z}{};
    ($aseqno, $offset) = split(/\t/);
    $ders{$aseqno} = $offset;
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
        $ok = 0;
    }
    if ($name =~ s{\Aa\(n\) *== *}{}) {
        $ok = 0;
    }
    $name =~ s{\Aa\(n\) *= *}{}; # remove leading "a(n) = "
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
            $ok = 0;
        }
    } elsif ($name =~ s{ *unless +n *(.*)\Z}{}){
        $cond = $1; 
        if ($cond =~ m{\= *0 *\Z}) {
            $cond = 1; # >= 1
        } else {
            $ok = 0;
        }
    } # with condition
    $name =~ s{\A *\((.*)\) *\Z}{$1}; # remove outer parentheses
    if ($name =~ s{ +mod *(\S+) *\Z}{}) {
        $name = "mod($name,$1)";
    }
    $name =~ s{\A *\((.*)\) *\Z}{$1}; # remove outer parentheses
    if ($ok == 1 and ! defined($ders{$aseqno}) and ($name !~ m{X\d{6}}) and ($name =~ m{A\d{6}})) {
        foreach my $index ($name =~ m{A\d{6}_\d+\(([^\)]+)\)}g) {
            if ($index !~ m{\An([\+\-]\d+)?\Z}) {
                $ok = 0;
            }
        } # for $index
        if ($ok == 1) {
            $name =~ s{\'}{}g;
            my $md5 = Digest::MD5->new;
            $md5->add($name);
            print join("\t", $aseqno, $md5->hexdigest, "~~$name" . ($cond ne "" ? "~~$cond" : "")) . "\n"; # substr() = pattern column for seq3
        }
    }
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
