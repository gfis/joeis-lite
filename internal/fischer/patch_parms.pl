#!perl

# Patch parameter file for gen_pattern.pl
# @(#) $Id$
# 2019-04-08, Georg Fischer
#
#:# Usage:
#:#   perl patch_parms.pl [-d debug] infile > outfile
#:#       infile has the format: ASEQNO CALLPATTERN PARM1 PARM2 ...
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
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $patch_count = 0;
while (<>) { # read inputfile
    next if m{\A\s*\#}; # skip comment lines
    next if m{\A\s*\Z}; # skip empty lines
    my $line = $_;
    $line =~ s/\s+\Z//; # chompr
    if ($debug >= 1) {
        print "$line\n";
    }
    my @parms        = split(/\t/, $line);
    my $aseqno       = $parms[0];
    my $call_pattern = $parms[1];
                if ($debug >= 1) {
                    print STDERR "aseqno=$aseqno\n"
                        . "call_pattern=$call_pattern\n"
                        . "parm2=$parms[2]\n"
                        . "parm3=$parms[3]\n"
                        . "parm4=$parms[4]\n"
                }
    if ($call_pattern =~ m{(\d+)\Z}) { # maybe patched
        my $parm_no = $1;
        if (0) {
        } elsif ($call_pattern =~ m{LinearRecurrence(\d)}) {
        	  my $variant = $1;
            my @signatures = split(/\,/, $parms[2]);
            my @initerms   = split(/\,/, $parms[3]);
            my $prepno = scalar(@initerms) - scalar(@signatures);
                if ($debug >= 1) {
                    print STDERR "prepno=$prepno, sigs="
                    		. join(";", @signatures)
                    		. ", terms=" 
                    		. join(";", @initerms)
                    		. "\n"
                }
            if ($prepno > 0 and $variant == 3) {
            		my @prepterms  = splice(@initerms, 0, $prepno);
                $parms[3] = join("\,", @initerms );
                $parms[4] = join("\,", @prepterms);
                $patch_count ++;
          	} # prepno > 0
          	$parms[2] = join("\,", reverse @signatures);
        }
        $line = join("\t", @parms);
    } # patched
    print "$line\n";
} # while <>
print STDERR "# $patch_count lines modified\n";
#--------------------------------------------
__DATA__
A068377 LinearRecurrence3 3,-3,1  1,6,20,42 4
A075412 LinearRecurrence2 11,-10  0,3 2
A079289 LinearRecurrence3 1,3,-2,-2 1,1,2,3,6 5
A092136 LinearRecurrence2 7,-1  0,1 2
A097923 LinearRecurrence3 1,0,1,-1,1,-1,0,-1,1  1,1,1,2,2,3,4,4,5,8,9,10,11,13,14,15,17,18,21 19
A122876 LinearRecurrence3 1,-1  1,1,2 3
A125916 LinearRecurrence3 0,0,0,0,0,0,0,0,0,1 0,1,1,0,1,1,2,2,1,2,2 11
