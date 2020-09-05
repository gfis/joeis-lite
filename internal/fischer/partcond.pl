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
my $offset = 1;
my $terms;
my %callcodes = qw(
    partcond  A035536
    );
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
    my $iparm;
    if ($line =~ m{apparent|empirical|conject}i) {
        # ignore the unproven
    #--------------------------------
    } elsif ($cc =~ m{\Apartcond}) {
        if (0) {
        # A035534   null    Number of partitions of n with equal number of parts congruent to each of 0 and 1 (mod 3).  nonn,   0..1000
        # A035572   null    Number of partitions of n with equal number of parts congruent to each of 0, 1 and 2 (mod 5)    nonn,synth  0..59
        } elsif ($name =~ m{\ANumber of partitions of n with equal number of parts congruent to each of (.*)}) {
            my $cond = $1;
            $cond =~ s{mod (\d+)}{};
            my $m = $1;
            my @modules = ();
            for (my $ind = 0; $ind < $m; $ind ++) {
                $modules[$ind] = 0; # preset with 0
            }
            my $set = 1;
            foreach my $k ($cond =~ m{(\d+)}g) {
                $modules[$k] = $set;
                $set = -1;
            } # foreach
            $iparm = 0;
            $parms[$iparm ++] = $offset;
            $parms[$iparm ++] = "A035536";
            $parms[$iparm ++] = scalar(@modules);
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
            $iparm = 0;
            $parms[$iparm ++] = $offset;
            $parms[$iparm ++] = "A035679";
            $parms[$iparm ++] = $m;
            $parms[$iparm ++] = join(",", @modules);
        } else {
            print STDERR "$line\n";
            $callcode = $VOID;
        }
    #--------------------------------
    } # switch callcodes
    if (0) { # no output
    } elsif ($callcode ne $VOID) {
    	$parms[9] = $name;
        print join("\t", $aseqno, $callcode, @parms) . "\n";
    } # conditional output
} # while <>
#----------------
#----------------
__DATA__
