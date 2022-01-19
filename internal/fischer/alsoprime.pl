#!perl

# Extract "Primes p such that f(p) is also prime"
# @(#) $Id$
# 2022-01-19, Georg Fischer: RN=73
#
#:# Usage:
#:#   grep "is also prime" $(COMMON)/joeis_names.txt \
#:#   | perl alsoprime.pl [-d debug] > output
#-------------------------------------------------
use strict;
use integer;
use warnings;
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

my ($aseqno, $superclass, $name, @rest);
while (<>) {
    my $line = $_;
    next if $line !~ m{\AA\d+};
    $line =~ s/\s+\Z//; # chompr
    ($aseqno, $superclass, $name, @rest) = split(/\t/, $line);
    next if $name !~ m{Primes};
    next if $name =~ m{revers};
    if (0) {
    } elsif ($name =~ m{p such that ([p0-9\+\-\^\*\/\(\) ]+) is}) {
      my $expr = $1;
      $expr =~ s{ }{}g;
      $expr =~ s{(\d)([a-z\(])}{$1\*$2}g;
      print join("\t", $aseqno, "alsoprime", 1, $expr, "", $superclass, $name, $rest[1]) . "\n";
    }
   
} # while 
__DATA__
    if (0) {
    } elsif ($name =~ m{\Aprime\(n\)\^(\d+)\*\(prime\(n\)\-1\)}) {
            $result = "mNP.pow($1).multiply(mNP.subtract(Z.ONE))";
        
    } elsif ($name =~ m{\Aprime\(n\)\^(\d+)\-prime\(n\)(\^(\d+))?}) {
        my $exp2 = $3 || 1;
        if ($exp2 == 1) {
            $result = "mNP.pow($1).subtract(mNP)";
        } else {
            $result = "mNP.pow($1).subtract(mNP.pow($exp2))";
        }
        
    } elsif ($name =~ m{\A\(prime\(n\)\^(\d+)\-prime\(n\)(\^(\d+))?\)\)?(\/(\d+))?}) {
        my $exp2 = $3 || 1;
        my $div  = $5 || 1;
        if ($exp2 == 1) {
            $result = "mNP.pow($1).subtract(mNP)";
        } else {
            $result = "mNP.pow($1).subtract(mNP.pow($exp2))";
        }
        if ($div != 1) {
            $result .= ".divide(Z.valueOf($div))";
        }
    } else {
    }
 