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
my  ($aseqno, $callcode, $offset, $seqtype, $prefix, $initer, $period, $termlist, @rest);

while (<>) {
    s/\s+\Z//; # chompr
    $line = $_;
    next if $line !~ m{\AA\d+}; # skip lines that do not start with an A-number
    ($aseqno, $callcode, $offset, $seqtype, $prefix, $initer, $period, $termlist, @rest) = split(/\t/, $line);
    $callcode = "eulerxfm";
    if ($prefix !~ m{\?}) {
        if ($prefix =~ m{\A\s*\Z}) { # empty
            $prefix = "new Z[0]";
        }
        my $instance = "";
        if (0) {
        } elsif ($seqtype == 1) {
            $instance = "new FiniteSequence($initer)";
        } elsif ($seqtype == 2) {
            $instance = "new PeriodicSequence($initer)";
        } elsif ($seqtype == 3) {
            $instance = "new PaddingSequence(new long[] { $initer }, new long[] { $period })";
        } else {
            print "#** $aseqno invalid seqtype=$seqtype\n";
        }   
        my $termno = scalar(split(/\,/, $termlist));
        print join("\t", $aseqno
           , $callcode, $offset, $seqtype, $prefix, $instance, $termno) . "\n";
    } else {
    	print STDERR "$line\n";
    }
} # while <>
#================================
__DATA__

