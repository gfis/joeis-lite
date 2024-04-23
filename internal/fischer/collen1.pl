#!perl

# insert lengths of records in 2nd column
# @(#) $Id$
# 2024-04-10, Georg Fischer
use strict;
use integer;
use warnings;

while (<>) {
    next if m{\A\s*\Z};
    my ($aseqno, @rest) = split(/\t/);
    print join("\t", $aseqno, length($_), @rest);
}
