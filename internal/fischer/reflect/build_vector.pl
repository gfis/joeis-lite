#!perl

# Build a vector of classification codes for all A-numbers 0..400000
# @(#) $Id$
# 2024-05-16, Georg Fischer: copied from scripts/endirect.pl; *HA=67
#
#:# Usage:
#:#   perl build_vector.pl [-f directfile] [-k] infile > outfile
#:#        -k use known.txt
#
# Read codes for the vector from files in this order (records contain "Annnnnn\tcode..."): 
# (default)  'A' for unimplemented sequences
# dirimp.txt 'E' inherits DirectSequence from LambdaSequence etc.
#            'M' extends MemorySequence with a(Z) and a(int)
#            'X' extends DecimalExpansionSequence etc.
#            'J' for all other sequences already implemented in jOEIS
# dirseq.txt 'D' with explicit "implements DirectSequence" 
# known.txt  'K' known functions that can be used directly
# funct.txt  'F' for math.function.Functions
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
my $pwd = `pwd`;
my $procname;
$pwd =~ m{(/gits/)};
my $gits = $`. "/gits"; # prematch

my $debug   = 0;
my $clip    = 0; # whether to read from clipboard instead from <>
my $reflect = "$gits/joeis-lite/internal/fischer/reflect";
my $known   = 0; # ignore known.txt 
my $max_anumber = 400000; # > 373700 at 2024-06-16
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{c}) {
        $clip      = 1;
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{k}) {
        $known     = 1; # use known.txt
    } elsif ($opt  =~ m{f}) {
        $reflect   = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $last_strip = `tail -n1 $gits/OEIS-mat/common/stripped`;
if ($last_strip  =~ m{A(\d+)}) {
    $max_anumber = $1;
}
my @vector = ();
for (my $sno = 0; $sno <= $max_anumber; $sno ++) {
    $vector[$sno] = 'A'; # set the default
}
&read_file("$reflect/dirimp.txt");
&read_file("$reflect/dirseq.txt");
&read_file("$reflect/known.txt") if $known > 0;
&read_file("$reflect/funct.txt");

open (OUT, ">", "$reflect/vector.txt") || die "cannot write vector.txt";
print OUT join("", @vector) . "\n";
close OUT;
print "# reflect/vector.txt for A000000..A$max_anumber generated by $gits/OEIS-mat/$0 at $timestamp\n";
#----
sub read_file { # format is aseqno tab code1
    my ($direct_file) = @_;
    open(DIR, "<", $direct_file) || die "cannot read \"$direct_file\"\n";
    while (<DIR>) {
        if (m{^A(\d+)\s+([A-Z])}) {
            my ($seqno, $code) = ($1, $2);
            $vector[$seqno] = $code;
        }
    } # while <DIR>
    close(DIR);
} # read_file
__DATA__
JJJJJFJJJEFJFJJJJJJAJJJJJJJJJJKJFJJKJJJJFFJJJFJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJDJMJJJKJJJJJJJJJJJJJJJJJJJJJJFJFJJJJJJJJJFJJJJJJJ
