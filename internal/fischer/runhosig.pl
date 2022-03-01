#!perl

# make runholo for a signature
# @(#) $Id$
# 2022-03-01, Georg Fischer
#
#:# Usage:
#:#    perl runhosig.pl signature inits [offset]
#--------------------------------

my $signat = shift(@ARGV); 
my $inits  = shift(@ARGV);
my $offset = shift(@ARGV) || 0;

$signat =~ s{[^\-0-9\,]}{}g;
my @signats = split(/\,/, $signat);
my @inits   = split(/\,/, $inits );
$inits  =~ s{[^\-0-9\,]}{}g;
my $matrix = "[[0],[" . join("],[", reverse(@signats)) . "],[-1]";
my $runholo = "make runholo MATRIX=\"$matrix\" INIT=\"$inits\" OFFSET=$offset NT=64";
my $java    = "    super($offset, \"$matrix\", \"$inits\", 0);\n";
print "$java\n";
print "$runholo\n";
print `$runholo` . "\n";
print scalar(@signats) . " dependants in recurrence, " . scalar(@inits) . " initial terms\n";
__DATA__
perl runhosig.pl "{5,-8,0,15,-18,3,16,-19,0,19,-16,-3,18,-15,0,8,-5,1}" "1, 5, 21, 72, 214, 563, 1344, 2958, 6086, 11820, 21854, 38713, 66069"  5
