#!perl

# Distribute the sources in ./manual
# @(#) $Id$
# 2021-09-10, Georg Fischer
use strict; 

my @names;
my @dirs;
my $tarpath = "../../src/irvine/oeis/";
foreach my $name(glob("manual/*.java")) {
    $name =~ 
while (<>) {
    my ($aseqno, @rest) = split(/\t/); 
	my $path = "../../src/irvine/oeis/" . lc(substr($aseqno, 0, 4)) . "/"; 
	my $ignore = `mkdir $path`; 
	print `cp -v manual/$aseqno.java $path`;  $@.gen 2> x.tmp
