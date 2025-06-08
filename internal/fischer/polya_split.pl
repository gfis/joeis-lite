#!perl

# Extract A-numbers from polys in (poly|polyx|polyz).jpat and move them to the end for (polya|polyxa|polza).jpat
# @(#) $Id$
# 2025-06-08: e.g.f. handling; *FP=11
# 2025-05-30: case were only $(PARM1) is present
# 2025-05-08, Georg Fischer; +WW2=80
#
#:# Usage:
#:#     perl polya_split.pl [-d mode] input.seq4 > output.seq4
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $debug = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my %restix = ("poly", 1, "polyx", 3, "polyz", 5); # index in @rest of new parameter for seqs
while (<>) {
#while (<DATA>) {
    s/\s+\Z//; # chompr
    my $line = $_;
    if ($line =~ m{\AA\d+\tpoly}) {
        my ($aseqno, $callcode, $offset, $polys, @rest) = split(/\t/, $line);
        my $postfix = $rest[0] || "";
        if ($callcode =~ m{\A(poly[xz]?)\Z}) {
            if ($polys =~ s{((\, *A\d+\!?)+)}{}) {
                my @anos = split(/\,/, substr($1, 1));
                $rest[$restix{$callcode}] = join(", ", map { 
                    ($_ =~ s{\!}{}) ? "egf(new $_())" : "new $_()"
                    } @anos);
                $postfix =~ s{\,s(\d)}{"\," . chr(ord('S') + $1)}eg;
                $callcode .= "a";
            } # with ",A"
        } # CC=poly.?
        $rest[0] = $postfix;
        $line = join("\t", $aseqno, $callcode, $offset, $polys, @rest);
    }
    print "$line\n";
} # while <>
#--------------------------------------------
__DATA__
# without A*
A146533	poly	0	"[1],[1,-4]"	"7,p1,sqrt,/,5,-,2,/"
A097514	polyx	0	"[1],[0,0,1]"	"x,exp,1,-,p1,2,/,-,exp"	0	1
A193543	polyz	0	"[1],[0,2]"	"1,p1,cosh,sqrt,/,int,rev,cosh"	0	1	0	2
# CC already ending with "a"
A168450	polya	0	"[1]"	"A,<1,S"	new A004304()

# with one A, no e.g.f.
A100325	poly	0	"[1],[1,-1],A003169"	"1,x,S,+,p1,x,S,<1,-,/"
A338671	polyx	0	"[1],[0,0,1],A038548"	"x,s0,^2,p1,s0,2,/"	1	0	 -i 1 @1!
A366104	polyz	0	"[1],A000700"	"x,s0,^4,x,neg,s0,^4,+,2,/"	0	0	0	2

# with one A, e.g.f
A295812	poly	1	"[1],A296170!"	"x,S,log,rev"
A208240	polyx	0	"[1],A000169!"	"1,1,x,S,-,/,x,S,x,S,^2,2,/,+,exp,-"	0	1
A208240	polyz	0	"[1],A000169!"	"1,1,x,S,-,/,x,S,x,S,^2,2,/,+,exp,-"	0	1	1	1

# with >=2 A, no e.g.f
A128327	poly	0	"[1],A128326,A030266"	"x,s1,s0"
A130524	polyx	0	"[1],A007857,A000108,A001764"	"x,s0,x,s1,*,x,s2,*"	0	0
A130524	polyz	0	"[1],A007857,A000108,A001764"	"x,s0,x,s1,*,x,s2,*"	0	0	0	1

# with >=2 A, e.g.f
A372193	poly	0	"[1],A057500!,A001858!"	"x,S,x,T,*"	0	1	fake
A372193	polyx	0	"[1],A057500!,A001858!"	"x,S,x,T,*"	0	1	
A143598	polyz	0	"[1],[0,-1],A143599!,A000001!"	"x,S,p1,S,*,sqrt"	0	1	0	2	fake

# mixed
A372193	poly	0	"[1],A057500,A001858!"	"x,S,x,T,*"	0	1	fake
A372193	polyx	0	"[1],A057500!,A001858"	"x,S,x,T,*"	0	1	fake
A143598	polyz	0	"[1],[0,-1],A143599,A000001!"	"x,S,p1,S,*,sqrt"	0	1	0	2	fake

