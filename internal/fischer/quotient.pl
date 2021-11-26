#!perl

# Extract sequences related to quotients of successive terms
# @(#) $Id$
# 2021-11-25, Georg Fischer
#
#:# Usage:
#:#   perl quotient.pl [-d debug] joeis_names.txt > quotient.gen
#-------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

my $debug = 0;
if (0 and scalar(@ARGV) < 0) {
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

my ($line, $aseqno, $superclass, $callcode, $name, $keyword, $range);
my $nseqno; # for numerator
my $dseqno; # for denominator
my $dmult;  # factor for denominator
while (<>) { # read inputfile
    s/\s+\Z//; # chompr
    $line = $_;
    ($aseqno, $superclass, $name, $keyword, $range) = split(/\t/, $line);
    $callcode = "quot";
    $nseqno = "";
    $dseqno = "";
    $dmult = "1";
    # print "$name\n";
    if (0) {
    #----------------
    # A203708	null	v(n+1)/v(n), where v=A203707.	nonn,synth	11
    } elsif ($name =~ 
        #   1------------1 2------2                                            3----3
        m{\A(a\(n\) *\= *)?([au-z])\(n *\+ *1\) *\/ *\2\(n\)\, *where *\2 *\= *(A\d+)} ) {
        $nseqno = $3;
        $callcode .= "s";
        &output();
    #----------------
    # A203481	null	v(n+1)/(4*v(n)), where v=A203479.	nonn,synth	11
    } elsif ($name =~ 
        #   1------------1 2------2                   3----3                    4----4
        m{\A(a\(n\) *\= *)?([au-z])\(n *\+ *1\) *\/ *\((\d+) *\* *\2\(n\)\)[^A]*(A\d+)} ) {
        $nseqno = $4;
        $dmult  = $3;
        $callcode .= "s";
        &output();
    #----------------
    # A203513	null	a(n) = A203312(n+1)/A203312(n).	nonn,changed,synth	12
    } elsif ($name =~ 
        #   1------------1 2----2
        m{\A(a\(n\) *\= *)?(A\d+)\(n *\+ *1\) *\/ *\2\(n\)}) {
        $nseqno = $2;
        $callcode .= "s";
        &output();
    #----------------
    # ??                a(n) = A203312(n+1)/(4*A203312(n))
    } elsif ($name =~ 
        #   1------------1 2----2                   3----3
        m{\A(a\(n\) *\= *)?(A\d+)\(n *\+ *1\) *\/ *\((\d+) *\* *\2\(n\)\)}) {
        $nseqno = $2;
        $dmult  = $3;
        $callcode .= "s";
        &output();
    #----------------
    # A331311	null	a(n) = A331287(n) / A331310(n).
    } elsif ($name =~ 
        #   1------------1 2----2           3----3
        m{\A(a\(n\) *\= *)?(A\d+)\(n\) *\/ *(A\d+)\(n\) *([\.\,\;]|with)}) {
        $nseqno = $2;
        $dseqno = $3;
        &output();
    #----------------
    # A331311	null	a(n) = A331287(n) / (4*A331310(n)).
    } elsif ($name =~ 
        #   1------------1 2----2             3---3      4----4
        m{\A(a\(n\) *\= *)?(A\d+)\(n\) *\/ *\((\d+) *\* *(A\d+)\(n\)\) *([\.\,\;]|with)}) {
        $nseqno = $2;
        $dmult  = $3;
        $dseqno = $4;
        &output();
    #----------------
    # A203520	null	v(n)/A000178(n); v=A203518 and A000178=(superfactorials).	nonn,synth	11
    } elsif ($name =~ 
        #   1------------1 2------2           3----3            4----4
        m{\A(a\(n\) *\= *)?([au-z])\(n\) *\/ *(A\d+)\(n\)\)[^A]*(A\d+)}) {
        $nseqno = $4;
        $dseqno = $3;
        &output();
    #----------------
    } else { # ignore
        # print "? $line\n";
    }
} # while <>
#----
sub output {
    print join("\t", $aseqno, $callcode, 0, $nseqno, $dmult, $dseqno, $name) . "\n";
} # output  
__DATA__
