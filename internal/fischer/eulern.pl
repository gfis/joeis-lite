#!perl

# Preprocessor for CC=eulern
# @(#) $Id$
# 2020-12-03, Georg Fischer; SP=44
#
#:# Usage:
#:#   cat cat25.txt | cut -b4- | perl eulern.pl > $@.gen
#
#--------------------------------------------------------------------
use strict;
use integer;
use warnings;

my $callcode = 0;
while (<>) { # read inputfile
    s/\s+\Z//; # chompr
    $callcode = "eulern0";
    my $line = $_;
    if (0) {
    } elsif ($line =~ m{Inverse Euler transform}i) {
        # ignore 
    } elsif ($line =~ m{(Euler transform of |Inverse Euler transform is )(A\d+)}i) {
        my $rseqno = $2;
        $line =~ m{\A(A\d+)};
        my $aseqno = $1;
        if ($aseqo gt $rseqno) {
            print join("\t", $aseqno, $callcode, 0, ",1", $rseqno) . "\n";
        }
    }
} # while <>
__DATA__
