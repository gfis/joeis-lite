#!perl

# Extract parameters for partitions with conditions
# @(#) $Id$
# 2020-09-05, Georg Fischer: copied from deris.pl
#
#:# Usage:
#:#     grep -E "Number of partitions " $(COMMON)/joeis_names.txt \
#:#     | perl partcond.pl [-cc callcode] [-d debug] > partcond.gen
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#:#     -cc one of the callcodes partcond
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

my $debug = 0;
if (scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $cc;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-cc}i) {
        $cc         = shift(@ARGV);
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
#----------------
my $offset = 0;
my %levels = qw(first 1 second 2 third 3 ternary 3 fourth 4 4th 4 
                fifth 5 5th 5 sixth 6 6th 6 seventh 7 7th 7 8th 8 eighth 8 
                9th 9 ninth 9 10th 10 tenth 10); # for diffseq
my $VOID = "VOID";

my $line;
my @parms; # records in joeis_names.txt
my ($p1, $p2, $p3);

while (<>) {
    $line = $_;
    $line =~ s/\s+\Z//; # chompr
    my $callcode = $cc;
    my ($aseqno, $superclass, $name, @rest) = split(/\t/, $line);
    my $iparm = 0;
    @parms = ();
    if ($line =~ m{apparent|empirical|conject}i) {
        # ignore the unproven
    #--------------------------------
    } elsif ($cc =~ m{\Apartcond}) {
        if (0) {
        # A035534   null    Number of partitions of n with equal number of parts congruent to each of 0 and 1 (mod 3).  nonn,   0..1000
        # A035537	null	Number of partitions of n with equal nonzero number of parts congruent to each of 0 and 1 (mod 3).	nonn,synth	0..54
        # A035572   null    Number of partitions of n with equal number of parts congruent to each of 0, 1 and 2 (mod 5)    nonn,synth  0..59
        } elsif ($name =~ m{\ANumber of partitions of n with equal (nonzero )?number of parts congruent to each of (.*)}) {
        	my $nonzero = $1 || "";
            my $cond = $2;
            $cond =~ s{mod (\d+)}{}; # remove trailing "(mod m)"
            my $m = $1;
            my @modules = ($cond =~ m{(\d+)}g);
            $parms[$iparm ++] = $offset;
            if (0) {
            } elsif (scalar(@modules == 2)) { 
              $parms[$iparm ++] = (length($nonzero) == 0) ? "A035536" : "A035537";
            } elsif (scalar(@modules == 3)) { 
              $parms[$iparm ++] = (length($nonzero) == 0) ? "A035572" : "A035582";
            } elsif (scalar(@modules == 4)) { 
              $parms[$iparm ++] = (length($nonzero) == 0) ? "A046770" : "A046782";
            }
            $parms[$iparm ++] = $m;
            $parms[$iparm ++] = join(",", @modules);
  
        # A035679 Number of partitions of n into parts 8k+1 and 8k+2 with at least one part of each type
        } elsif ($name =~ m{\ANumber of partitions of n into parts ([^w]+)with at least one part of each type}) {
            my $cond = "$1,"; # terminated with ","
            $cond =~ s{and}{\,}; # inner ","
            $cond =~ s{[ \*]}{}g; # remove spaces and "*"
            $cond =~ s{[a-z]\,}{k\+0\,}g; # 8k -> 8k+0
            $cond =~ m{(\d+)}; # first number
            my $m = $1;
            my @modules = ($cond =~ m{${m}k\+(\d+)}g);
            $parms[$iparm ++] = $offset;
            $parms[$iparm ++] = "A035679";
            $parms[$iparm ++] = $m;
            $parms[$iparm ++] = join(",", @modules);

       # A036801 Number of partitions satisfying (cn(0,5) <= cn(2,5) and cn(0,5) <= cn(3,5) and cn(0,5) <= cn(1,5) and cn(0,5) <= cn(4,5)).	nonn,changed,synth	1..45
       # A036822 Number of partitions satisfying cn(1,5) = cn(4,5) = 0.	nonn,changed,	1..1000
       # A036846 Number of partitions of n such that cn(0,5) = cn(2,5) <= cn(3,5) = cn(4,5) <= cn(1,5).	nonn,synth	1..64
       # A036880 Number of partitions of 5n such that cn(0,5) <= cn(1,5) = cn(4,5) <= cn(2,5) = cn(3,5).	nonn,synth	1..33
       } elsif ($name =~ m{\ANumber of partitions (of \d*n )?(satisfying |such that )\(?(cn[^\.]+)}) {
            my $mult = $1 || "of n ";
            my $cond = $3;
            $mult =~ s{ n}{1n};
            $mult =~ m{(\d+)};
            $mult =  $1; # 1 or 5
            $cond =~ s{\)\)\.?\Z}{\)};
            $cond =~ s{ 0\)\.?\Z}{ 0};
            #          1                2           3                4           5
            $cond =~ s{(cn\(\d+,\d+\)|0)([\<\=\> ]+)(cn\(\d+,\d+\)|0)([\<\=\> ]+)(cn\(\d+,\d+\)|0)}{$1$2$3 and $3$4$5}g; # insert "and"
            $cond =~ s{(cn\(\d+,\d+\)|0)([\<\=\> ]+)(cn\(\d+,\d+\)|0)([\<\=\> ]+)(cn\(\d+,\d+\)|0)}{$1$2$3 and $3$4$5}g; # insert "and"
            $cond =~ s{(cn\(\d+,\d+\)|0)([\<\=\> ]+)(cn\(\d+,\d+\)|0)([\<\=\> ]+)(cn\(\d+,\d+\)|0)}{$1$2$3 and $3$4$5}g; # insert "and"
            $cond =~ s{and}{\&\&}g; 
            $cond =~ s{([^\<\>])\=([^\<\>])}{$1==$2}g; # "=" -> "=="
            $cond =~ m{cn\(\d+\,(\d+)}; # second parameter
            my $m = $1;
            $cond =~ s{cn\((\d+)\,$m\)}{"c\[" . ($1 + 2) . "\]"}eg;
            $parms[$iparm ++] = $offset;
            $parms[$iparm ++] = "A036801";
            $parms[$iparm ++] = $mult;
            $parms[$iparm ++] = $m;
            $parms[$iparm ++] = $cond;
            $callcode = "partcn";

        } else {
            print STDERR "$line\n";
            $callcode = $VOID;
        }
    #--------------------------------
    } # switch variant
    if (0) { # no output
    } elsif ($callcode ne $VOID) {
    	$parms[$iparm ++] = $name;
        print join("\t", $aseqno, $callcode, @parms) . "\n";
    } # conditional output
} # while <>
#----------------
#----------------
__DATA__
