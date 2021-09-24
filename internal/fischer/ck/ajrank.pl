#!perl

# A186159	null	Adjusted joint rank sequence of (f(i)) and (g(j)) with f(i) before g(j) when f(i)=g(j), where f and g are the triangular numbers and octagonal numbers.  Complement of A186274.	nonn,synth	100
# @(#) $Id$
# 2021-09-24, Georg Fischer

use strict;
my %gonal = qw (
  squares      A000290
  cubes        A000578
  triangular   A000217
  pentagonal   A000326
  hexagonal    A000384
  heptagonal   A000566
  octagonal    A000567
  odd          A005408
  i^2          A000290
  j^2          A000290
  );
  
my $fseqno;
my $gseqno;
my $aseqno;
my $cseqno;
my $order;
my $flag;

while (<>) {
# while (<DATA>) {
    my $line = $_;
    if ($line =~ m{\A(A\d+)\t\w+\tAdjusted joint rank sequence of}) { # starts with A-number
        my $aseqno = $1;
        $order = 0;
        $flag = 1;
        if (0) {
        } elsif ($line =~ m{before}) {
            $order = 0;
        } elsif ($line =~ m{after} ) {
            $order = 1;
        } else {
            print "# $aseqno: no order\n";
        }
        $line =~ s{ numbers| the}{}g;
        $line =~ m{ are ([\w\^]+) and ([\w\^]+)};
        $fseqno = $1;
        $gseqno = $2;
        $fseqno = $gonal{$fseqno} || $fseqno;
        $gseqno = $gonal{$gseqno} || $gseqno;
        
        $line =~ m{Complement of (A\d+)};
        $cseqno = $1;
        $flag = ($aseqno lt $cseqno) ? 1 : 2;
        $line =~ m{ where (.*)};
        my $rest = $1;
        if (($fseqno !~ m{\AA\d+\Z}) or ($gseqno !~ m{\AA\d+\Z})) {
            print "# ";
        }
        print join("\t", $aseqno, "ajrank", 0, $fseqno, $gseqno, $order, $flag, $rest) ."\n";
    } # if aseqno
} # while
#----
__DATA__
A186159	null	Adjusted joint rank sequence of (f(i)) and (g(j)) with f(i) before g(j) when f(i)=g(j), where f and g are the triangular numbers and octagonal numbers.  Complement of A186274.	nonn,synth	100
A186219	null	Adjusted joint rank sequence of (f(i)) and (g(j)) with f(i) before g(j) when f(i)=g(j), where f and g are the triangular numbers and squares.  Complement of A186220.	nonn,	10000
A186220	null	Adjusted joint rank sequence of (g(i)) and (f(j)) with f(i) before g(j) when f(i)=g(j), where f and g are the triangular numbers and squares.  Complement of A186219.	nonn,	10000
A186221	null	Adjusted joint rank sequence of (f(i)) and (g(j)) with f(i) after g(j) when f(i)=g(j), where f and g are the triangular numbers and squares.  Complement of A186222.	nonn,	10000
A186222	null	Adjusted joint rank sequence of (g(i)) and (f(j)) with f(i) after g(j) when f(i)=g(j), where f and g are the triangular numbers and squares.  Complement of A186221.	nonn,	10000
A186223	null	Adjusted joint rank sequence of (f(i)) and (g(j)) with f(i) before g(j) when f(i)=g(j), where f and g are the triangular numbers and pentagonal numbers.  Complement of A186224.	nonn,changed,synth	100
