#!perl

# Replace PrependSequence calls and introduce .prepend(), .adjust()
# @(#) $Id$ 
# 2026-11-15, Georg Fischer: *EFF=5
#
#:# Usage:
#:#   perl repl_adjust.pl [-d debug] [-p parmno] infile.seq4 > outfile.seq4
#:#       -p parmno  parameter number in seq4-format: p=1 changes $(PARM1)
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min);
if (0 && scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $debug      = 0; 
my $parmno     = 1;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{p}) {
        $parmno    = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my %znum = qw(
    Z.NEG_ONE -1
    Z.ZERO    0
    Z.ONE     1
    Z.TWO     2
    Z.THREE   3
    Z.FOUR    4
    Z.FIVE    5
    Z.SIX     6
    Z.SEVEN   7
    Z.EIGHT   8
    Z.NINE    9
    Z.TEN    10
    );
while (<>) { # read inputfile
# while (<DATA>) { # read inputfile
    s{\s+\Z}{}; # chompr
    my $line = $_;
    next if ($line !~ m{\AA\d+});
    my ($aseqno, $cc, @parms) = split(/\t/, $line);
    my $parm = $parms[$parmno];
    $parm =~ s{(Z\.\w+)([\,\)])}{$znum{$1}$2}g;
    # new PrependSequence(new A048272(), 0) 
    #                                 1          1     2    2 ( )3    34      5          5 4 )
    $parm =~ s{\Anew PrependSequence\((\-?\d+\, *)?new (A\d+)\(\)(\, *)(\-?\d+(\, *\-?\d+)*)\)} 
              {new $2\(\)\.prepend\($4\)};
    # A014138	partsum	0	new PrependSequence(new A000108().skip(1), Z.ZERO)	  
    #                                 1          1     2    2 ( )       (3   3 )4    45      6          6 5 )
    $parm =~ s{\Anew PrependSequence\((\-?\d+\, *)?new (A\d+)\(\)\.skip\((\d*)\)(\, *)(\-?\d+(\, *\-?\d+)*)\)} 
              {"new $2\(\)\.adjust\(" . ($3 || 1) . ", $5\)"}e;
	    $parms[$parmno] = $parm;
    print join("\t", $aseqno, $cc, @parms) ."\n";
} # while <>
__DATA__
A014138	partsum	0	new PrependSequence(new A000108().skip(1), Z.ZERO)	  
A014200	partsum	0	new PrependSequence(new A002654(), Z.ZERO)	  
A014284	partsum	1	new A008578()	  
A014406	partsum	1	new A014405()	  
A014605	partsum	0	new PrependSequence(new A001935(), Z.ONE, Z.ZERO, Z.ZERO, Z.ZERO)	  
A059851	partsum	0	new PrependSequence(new A048272(), 0)	  
A060389	partsum	1	new A002110().skip(1)	  
A374534	partsum	0	new PrependSequence(0, new A111938(), 0)	  

