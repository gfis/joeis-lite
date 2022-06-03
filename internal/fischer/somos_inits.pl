#!perl

# Insert initial terms for Somos-like recurrences into seq4.parm2 field
# @(#) $Id$
# 2022-05-31, Georg Fischer
#
#:# Usage:
#:#   perl somos_inits.pl input.seq4 > output.seq4 
#:#
#:# Reads terms from $(COMMON)/asdata.txt.
#:# Column parm2 must contain "m:inits", 
#:# where m is the number of initial terms,
#:# and inits must be a substring of the data list with sufficient length
#-------------------------------------------------
use strict;
use integer;
use warnings;

while (<>) {
# while (<DATA>) {
    my $line = $_;
    next if $line !~ m{\AA\d+};
    $line =~ s/\s+\Z//; # chompr
    next if $line !~ m{\AA\d+};
    my ($aseqno, $callcode, @parms) = split(/\t/, $line);
    my $ninits    = $parms[1]; # start with order
    my $init_list = $parms[3];
    my @inits = split(/\, */, $init_list);
    my $in = 0;
    while ($inits[$in ++] == 0 && $in < scalar(@inits)) {
        $ninits ++;
    }
    if ($ninits >= scalar(@inits) - 1) {
        print STDERR "# $aseqno needs more than $ninits initial terms, has " . scalar(@inits) . ": ". join(",", @inits) . "\n";
    } else {
        my @terms = splice(@inits, 0, $ninits);
        $parms[3] = join(",", @terms);
        print join("\t", $aseqno, $callcode, @parms) . "\n";
    }
} # while 
__DATA__
A165905	somos4	0	4	0	0,1,2,1,1,1,12312	1	1	
A162546	somos4	0	4	0	0,0,1,2,1,1,1,12312	36	-68	Somos-4 variant:
A171422	somos4	0	4	0	0,1,2,1,1,21321	-4	-5	Somos-4 sequence
A174017	somos4	0	4	0	0,1,2,1,12312	1	1	Somos-4 sequence
