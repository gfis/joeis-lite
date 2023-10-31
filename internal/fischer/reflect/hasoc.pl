#!perl

# Prepare data for table 'hasoc'
# @(#) $Id$
# 2023-07-20, Georg Fischer: copied from level1.pl
#
#:# Usage:
#:#   find src/irvine/oeis -iname "*.java" | xargs -l grep -P "(public|protected) \w+\(final *int *offset" \
#:#   | perl hasoc.tmp [-d debug] > outfile
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
my $colno = 3;
my $debug = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $aseqno;
my $line;
my $count = 0;
while (<>) { # read inputfile
    s{\s+\Z}{}; # chompr
    $line = $_;
    #                  1                1  2    2  3      3
    if ($line =~ m{\A *(public|protected) *(\w+)\(([^\)]+)}) {
        my ($aseqno, $parms) = ($2, $3);
        $parms =~ s{final *}{}g;
        $parms =~ s{ }{_}g;
        my @commas = ($parms =~ m{(\,)}g);
        $count ++;
        # $parms =~ s{final int offset(\; *)?}{};
        print join("\t", $aseqno, scalar(@commas) + 1, $parms) . "\n";
    }
} # while <>
print STDERR "# $count records written\n";

__DATA__
  public A180177(final int offset, final int omit) {
  public A180517(final int offset, final int digit1, final int digit2) {
  protected A023024(final int offset) {
  protected A023416(final int offset) {
  protected A023094(final int offset) {
  protected A023847(final int offset) {
  public A023847(final int offset, final int nf, final int mf, final int ma) {
  public A130433(final int offset, final int base) {
  public A130162(final int offset, final AbstractSequence seq) {
