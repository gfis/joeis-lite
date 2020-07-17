#!perl

# Patch parameter file for gen_pattern.pl
# @(#) $Id$
# 2019-04-08, Georg Fischer
#
#:# Usage:
#:#   perl patch_parms.pl [-d debug] [-a action] [-i initial] infile > outfile
#:#       -a action: lrmmac, lrstrip ...
#:#       -i number of additional initial terms, default: 0
#:#       infile has the format: ASEQNO CALLPATTERN PARM1 PARM2 ...
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);
if (scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $debug = 0;
my $action = "lrmmac";
my $iniadd = 0; # no additional terms
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{a}) {
        $action    = shift(@ARGV);
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{i}) {
        $iniadd    = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $patch_count = 0;
my $aseqno;
my $callcode;
my $offset;
while (<>) { # read inputfile
    s{\s+\Z}{}; # chompr
    next if m{\A\s*\#}; # skip comment lines
    next if m{\A\s*\Z}; # skip empty lines
    my $line = $_;
    if ($debug >= 1) {
        print "$line\n";
    }
    my @parms = ("", "", "", "", ""); # offset and $(PARM1-4)
    ($aseqno, $callcode, @parms) = split(/\t/, $line);
    $offset     = $parms[0];  # align it with $(PARM1) ...
    $callcode   =~ m{(\d+)\Z}; # may be patched
    my $parm_no = $1; # 2 or 3
    my $variant = $1;
    my @signatures = split(/\,/, $parms[1]);
    my @initerms   = split(/\,/, $parms[2]);
    if (0) {
    } elsif ($action =~ m{lrmmac}) { 
        # aseqno callcode offset linrec(2|3) signature initerms           ->
        # aseqno callcode offset linrec(2|3) revsignat initerms prepterms
        my $prepno    = scalar(@initerms) - scalar(@signatures);
        if ($prepno > 0 and $variant == 3) {
            my @prepterms  = splice(@initerms, 0, $prepno);
            $parms[2] = join("\,", @initerms );
            $parms[3] = join("\,", @prepterms);
            $patch_count ++;
        } # prepno > 0
        $parms[1] = join("\,", reverse @signatures);
     
    } elsif ($action =~ m{lrstrip}) {
        # aseqno callcode offset linrec2     signature stripped_terms           ->
        # aseqno callcode offset linrec(2|3) revsignat initerms # rest of stripped
        my $sigorder  = scalar(@signatures);
        my $termno    = scalar(@initerms);
        if ($iniadd + $sigorder <= $termno) {
            my @prepterms  = splice(@initerms, 0, $iniadd); # @initerms is shifted left
            my @restterms  = splice(@initerms, $sigorder, $termno - $sigorder - $iniadd);
            $parms[2] = join("\,", @initerms );
            if ($iniadd == 0) {
                $callcode = "linrec2";
                $parms[3] = "# " . join("\,", @restterms);
            } else { # $variant == 3
                $callcode = "linrec3";
                $parms[3] =        join("\,", @prepterms);
                $parms[4] = "# " . join("\,", @restterms); 
            }
            $patch_count ++;
        } # prepno > 0
        $parms[1] = join("\,", reverse @signatures);

    } else { 
        print STDERR "invalid action \"$action\"\n";
        exit();
    }
    print join("\t", $aseqno, $callcode, @parms) . "\n";
} # while <>
print STDERR "# $patch_count lines modified\n";
#--------------------------------------------
__DATA__
A068377 linrec3 0 3,-3,1  1,6,20,42 4
A075412 linrec2 0 11,-10  0,3 2
A079289 linrec3 0 1,3,-2,-2 1,1,2,3,6 5
A092136 linrec2 0 7,-1  0,1 2
A097923 linrec3 0 1,0,1,-1,1,-1,0,-1,1  1,1,1,2,2,3,4,4,5,8,9,10,11,13,14,15,17,18,21 19
A122876 linrec3 0 1,-1  1,1,2 3
A125916 linrec3 0 0,0,0,0,0,0,0,0,0,1 0,1,1,0,1,1,2,2,1,2,2 11
