#!perl

# Extract A-numbers from polys in (poly|polyx|polyz).jpat and move them to the end for (polya|polyxa|polza).jpat
# @(#) $Id$
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

my %restix = ("poly", 0, "polyx", 2, "polyz", 4); # index in @rest of new parameter for seqs 
while (<>) {
#while (<DATA>) {
    s/\s+\Z//; # chompr
    my $line = $_;
    if ($line =~ m{\AA\d+\t}) {
        my ($aseqno, $callcode, $offset, $polys, $postfix, @rest) = split(/\t/, $line);
        if ($callcode =~ m{\A(poly[xz]?)\Z}) {
            if ($polys =~ s{((\,A\d+)+)}{}) { 
                my @anos = split(/\,/, substr($1, 1));
                $rest[$restix{$callcode}] = join(", ", map { "new $_()"} @anos);
                $postfix =~ s{\,s(\d)}{"\," . chr(ord('S') + $1)}eg; 
                $callcode .= "a";
            } # with ",A"
        } # CC=poly.?
        $line = join("\t", $aseqno, $callcode, $offset, $polys, $postfix, @rest);
    }
    print "$line\n";
} # while <>
#--------------------------------------------
__DATA__
A327074	poly	0	"[0,0,1],[0,0,1],A007145"	"1,x,s0,p1,s0,+,2,/"	 -i 3 @1!
A331233	poly	0	"[1],[0,0,1],A000081"	"x,s0,1,x,s0,+,x,s0,^2,p1,s0,+,2,/,+,<1,-"	 @0   
A335349	poly	0	"[1],A002426,A001006"	"x,s0,^5,<4,2,*,x,s1,^3,*"	@4   
A338671	polyx	0	"[1],[0,0,1],A038548"	"x,s0,^2,p1,s0,2,/"	1	0	 -i 1 @1!  
A339302	poly	0	"[1],[0,0,1],A000081"	"x,s0,^4,p1,s0,^2,+,2,/"	@4   
