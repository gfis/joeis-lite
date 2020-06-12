#!perl

# Generate Jasinski's sequences expr(n-th prime)
# @(#) $Id$
# 2020-06-12, Georg Fischer
#
#:# Usage:
#:#   perl nthprime.pl [-d debug] > nth_prime.gen
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
while (<DATA>) {
    my $line = $_;
    next if $line !~ m{\AA\d+};
    $line =~ s/\s+\Z//; # chompr
    my $result = "";
    ($aseqno, $superclass, $name, @rest) = split(/\t/, $line);
    $name =~ s{\Aa\(n\) *\= *}{};
    $name =~ s{\..*}{};
    if ($name =~ s{ *\,? *where +p *=.*}{}) {
        $name =~ s{p}{prime\(n\)}g;
    }
    $name =~ s{\(n\-th prime\)}{prime\(n\)}g;
    $name =~ s{\(n\-th prime\^(\d)\)}{prime\(n\)\^$1}g;
    $name =~ s{\(prime\(n\)\)\^(\d)}{prime\(n\)\^$1}g;
    $name =~ s{ }{}g;
    # now patch 2 types of errors:
    # $name =~ s{n\-th prime\^}{n\-th prime\)\^}g;
    # $name =~ s{\)\)\/}{\)\/}g;
    my $result = $name;
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
    
    print join("\t", $aseqno, "nthprime", 0, $result, $name, $rest[1]) . "\n";
} # while 
__DATA__
A138401	null	a(n) = prime(n)^4 - prime(n).	nonn,easy,	1..200
A138402	null	a(n) = (n-th prime)^4-(n-th prime)^2.	nonn,easy,	1..200
A138403	null	a(n) = p^3*(p-1), where p = prime(n).	nonn,easy,	1..200
A138404	null	a(n) = prime(n)^5 - prime(n).	nonn,easy,	1..200
A138405	null	a(n) = prime(n)^5 - prime(n)^2.	nonn,easy,	1..200
A138406	null	a(n) = prime(n)^5 - prime(n)^3.	nonn,easy,	1..200
A138407	null	a(n) = p^4*(p-1), where p = prime(n).	nonn,easy,	1..200
A138408	null	a(n) = prime(n)^6 - prime(n).	nonn,easy,	1..200
A138409	null	a(n) = prime(n)^6 - prime(n)^2.	nonn,easy,	1..200
A138410	null	a(n) = prime(n)^6 - prime(n)^3.	nonn,easy,	1..200
A138411	null	a(n) = prime(n)^6 - prime(n)^4.	nonn,easy,	1..168
A138412	null	a(n) = p^5*(p-1) where p =prime(n).	nonn,easy,	1..167
A138416	null	a(n) = (p^3 - p^2)/2, where p = prime(n).	nonn,easy,	1..168
A138417	null	a(n) = (prime(n)^4 - prime(n))/2.	nonn,easy,	1..200
A138418	null	a(n) = ((n-th prime)^4-(n-th prime)^2)/2.	nonn,easy,	1..200
A138419	null	a(n) = (prime(n)^4 - prime(n)^2)/3.	nonn,easy,	1..200
A138420	null	a(n) = ((prime(n))^4-(prime(n))^2)/4.	nonn,easy,	1..200
A138421	null	a(n) = (prime(n)^4 - prime(n)^2)/6.	nonn,easy,	1..200
A138422	null	a(n) = (prime(n)^4 - prime(n)^2)/12.	nonn,easy,	1..200
A138423	null	a(n) = (prime(n)^4 - prime(n)^3)/2.	nonn,easy,	1..200
A138424	null	a(n) = (prime(n)^5 - prime(n))/2.	nonn,easy,	1..200
A138425	null	a(n) = (prime(n)^5 - prime(n))/3.	nonn,easy,	1..200
A138426	null	a(n) = ((prime(n))^5-prime(n))/5.	nonn,easy,	1..200
A138427	null	a(n) = (prime(n)^5 - prime(n))/6.	nonn,easy,	1..200
A138428	null	a(n) = (prime(n)^5 - prime(n))/10.	nonn,easy,	1..200
A138429	null	a(n) = (prime(n)^5 - prime(n))/15.	nonn,easy,	1..200
A138430	null	(prime(n)^5 - prime(n))/30.	nonn,easy,	1..200
A138431	null	a(n) = ((n-th prime)^5-(n-th prime)^2)/2.	nonn,easy,synth	1..24
A138432	null	a(n) = ((n-th prime)^5-(n-th prime)^3)/2.	nonn,easy,synth	1..24
A138433	null	a(n) = ((n-th prime)^5-(n-th prime)^3)/3.	nonn,easy,changed,synth	1..24
A138434	null	a(n) = ((n-th prime)^5-(n-th prime)^3)/4.	nonn,easy,	1..1000
A138435	null	a(n) = ((n-th prime)^5-(n-th prime)^3)/6.	nonn,easy,changed,	1..1000
A138436	null	a(n) = ((n-th prime)^5-(n-th prime)^3)/8.	nonn,easy,synth	1..25
A138437	null	a(n) = ((n-th prime)^5-(n-th prime)^3)/12.	nonn,easy,synth	1..26
A138438	null	a(n) = ((n-th prime)^5-(n-th prime)^3)/24.	nonn,easy,	1..1000
A138439	null	a(n) = ((n-th prime)^5-(n-th prime)^4)/2.	nonn,easy,synth	1..24
A138440	null	a(n) = ((n-th prime)^6-(n-th prime))/2.	nonn,easy,synth	1..21
A138441	null	a(n) = ((n-th prime)^6-(n-th prime^2))/2.	nonn,easy,synth	1..23
A138442	null	a(n) = ((n-th prime)^6-(n-th prime^2))/3.	nonn,easy,synth	1..21
A138443	null	a(n) = ((n-th prime)^6-(n-th prime^2))/4.	nonn,easy,synth	1..21
A138444	null	a(n) = ((n-th prime)^6-(n-th prime^2))/5.	nonn,easy,synth	1..22
A138445	null	a(n) = ((n-th prime)^6-(n-th prime^2))/6.	nonn,easy,synth	1..22
A138446	null	a(n) = ((n-th prime)^6-(n-th prime^2))/10.	nonn,easy,	1..1000
A138447	null	a(n) = ((n-th prime)^6-(n-th prime^2))/12.	nonn,easy,synth	1..23
A138448	null	a(n) = (prime(n)^6-prime(n)^2)/15.	nonn,easy,synth	1..23
A138450	null	a(n) = ((n-th prime)^6-(n-th prime^2))/30.	nonn,easy,changed,synth	1..24
A138451	null	a(n) = (prime(n)^6-prime(n)^2)/60.	nonn,easy,less,	1..1000
A138452	null	a(n) = ((n-th prime)^6-(n-th prime)^3))/2.	nonn,easy,	1..1000
A138453	null	a(n) = ((n-th prime)^6-(n-th prime)^4))/2.	nonn,easy,synth	1..21
A138454	null	a(n) = ((n-th prime)^6-(n-th prime)^4))/3.	nonn,easy,changed,	1..1000
A138455	null	a(n) = ((n-th prime)^6-(n-th prime)^4))/4.	nonn,easy,synth	1..21
A138456	null	a(n) = ((n-th prime)^6-(n-th prime)^4))/6.	nonn,easy,synth	1..22
A138457	null	a(n) = ((n-th prime)^6-(n-th prime)^4))/8.	nonn,easy,synth	1..22
A138458	null	a(n) = ((n-th prime)^6-(n-th prime)^4))/24.	nonn,easy,synth	1..23
A138459	null	a(n) = ((n-th prime)^6-(n-th prime)^4))/12.	nonn,easy,synth	1..23
A138460	null	a(n) = ((n-th prime)^6-(n-th prime)^5))/2.	nonn,easy,synth	1..21
