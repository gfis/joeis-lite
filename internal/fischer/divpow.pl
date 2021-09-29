#!perl

# Extract parameters for "Numbers k such that k^2 divides 13^k-1" etc.
# 2021-09.29, Georg Fischer: copied from numdiv.pl
#
#:# Usage:
#:#   perl divpow.pl [-d debug] $(COMMON)/joeis_names.txt > divpow.gen\
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $line = "";
my ($aseqno, $superclass, $callcode, $name, @rest);
my ($rseqno, $k, $kpow, $kexpr, $base, $add);
my $debug   = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $offset = 1;
$callcode = "divpow";
# while (<DATA>) { # from joeis_names.txt
while (<>) { # from joeis_names.txt
    s/\s+\Z//; # chompr
    $line = $_;
    ($aseqno, $superclass, $name, @rest) = split(/\t/, $line);
    # next if $superclass ne "null";
    my $k;
    if (0) {
    } elsif ($name =~ m{(Integers|Positive integers|Numbers) +([mnk]) +(such +that +\2 +divides|that divide|which divide) +(\d+)\^\2([ \d\+\-]+)?\.}) {
        #               1                                  1  2     2  3                                                3  4   4    5          5
        ($k,        $base, $add) = ($2,     $4, $5 || 0);
        $add =~ s{[\+ ]}{}g;
        $rseqno = "A014951";
        print join("\t", $aseqno, "parm3", $offset, $rseqno,        $base, $add, $name) . "\n"; 
    } elsif ($name =~ m{(Integers|Positive integers|Numbers) +([mnk]) +such +that +\2\^(\d+) +divides +(\d+)\^\2([ \d\+\-]+)?\.}) {
        #               1                                  1  2     2                  3   3           4   4    5          5
        ($k, $kpow, $base, $add) = ($2, $3, $4, $5 || 0);
        $add =~ s{[\+ ]}{}g;
        $rseqno = "A127103";
        print join("\t", $aseqno, "parm4", $offset, $rseqno, $kpow, $base, $add, $name) . "\n"; 
    } elsif ($name =~ m{(Integers|Positive integers|Numbers) +([mnk]) +such +that +\2\^(\d+) +divides +(\d+)\^\(\2\^2\)([ \d\+\-]+)?\.}) {
        #               1                                  1  2     2                  3   3           4   4           5          5
        ($k, $kpow, $base, $add) = ($2, $3, $4, $5 || 0);
        $add =~ s{[\+ ]}{}g;
        $rseqno = "A127263";
        print join("\t", $aseqno, "parm4", $offset, $rseqno, $kpow, $base, $add, $name) . "\n"; 
    }
} # while <>
__DATA__
A128405	null	Numbers k such that k^2 divides 12^k - 1.
A128678	null	Numbers k such that k^3 divides 4^(k^2) + 1.
A014946	null	Numbers k that divide 6^k-1.
A067945	null	Numbers k that divide 3^k - 1.	easy,nonn,changed,	1..10000	nyi
A014951	Sequ	Positive integers k such that k divides 12^k - 1.	nonn,changed,	1..100	unkn
A014959	Sequ	Integers n such that n divides 22^n - 1.	nonn,changed,	1..69065	unkn
