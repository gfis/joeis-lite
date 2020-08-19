#!perl

# Postprocess the output of EulerTransformTest CC=eulerx%
# 2020-08-19, Georg Fischer
#
#:# Usage:
#:#   perl eulerxfm_post.pl input > output
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $line = "";
my ($aseqno, $callcode, $offset, $seqtype, $prefix, $period, $perlen, @rest);

while (<>) {
    s/\s+\Z//; # chompr
    $line = $_;
    next if $line !~ m{\AA\d+}; # skip lines that do not start with an A-number
    ($aseqno, $callcode, $offset, $seqtype, $prefix, $period, $perlen, @rest) = split(/\t/, $line);
    $callcode = "eulerxfm";
    if ($prefix !~ m{\?}) {
        if ($prefix =~ m{\A\s*\Z}) { # empty
            $prefix = "new Z[0]";
        }
        if (0) {
        } elsif ($seqtype == 1) {
            $period = "new FiniteSequence($period)";
        } elsif ($seqtype == 2) {
            $period = "new PeriodicSequence($period)";
        } elsif ($seqtype == 3) {
            $period = "new EventuallyPeriodicSequence($perlen,  $period)";
        } else {
            print "#** $aseqno invalid seqtype=$seqtype\n";
        }   
        print join("\t", $aseqno, $callcode, $offset
            , $seqtype, $prefix, $period, $perlen, @rest) . "\n";
    } else {
    	print STDERR "$line\n";
    }
} # while <>
#================================
__DATA__

