#!perl

# Extract parameters for PositionSequence.java
# @(#) $Id$
# 2020-06-21, Georg Fischer: copied from posins.pl
#
#:# Usage:
#:#     grep -E "..." $(COMMON)/cat25.txt \
#:#     | cut -b4 | sed -e "s/ /\t/" \
#:#     | perl diffse.pl [-d debug] > diffseq.gen 2> diffseq.rest
#:# Reads deriv0.txt for implemented jOEIS sequences with their offsets.
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

my %levels = qw(first 1 second 2 third 3 ternary 3 fourth 4 4th 4 fifth 5 5th 5 sixth 6 6th 6 seventh 7 7th 7 8th 8);
my $line;
my ($aseqno, $offset1, $name, @rest); # records in joeis_names.txt
my $level;
my $cond;
my $callcode = "diffseq";
my $offset = 1;
my $rseqno;
my $DSEQNO = "A000000";
my $parm4  = "";
#----------------
my %ders = ();
my $der_name = "deriv0.tmp";
open (DER, "<", $der_name) || die "cannot read $der_name\n";
while (<DER>) {
    s{\s+\Z}{};
    ($aseqno, $offset) = split(/\t/);
    if ($offset < 0) {
        # skip 
        # $offset = chr(ord('Z') + 1 + $offset);
    } else {
        $ders{$aseqno} = $offset;
    }
} # while <DER>
close(DER);
print STDERR "# diffseq.pl: " . scalar(%ders) . " jOEIS offsets read from $der_name\n";
#----------------
while (<>) {
    $line = $_;
    $line =~ s/\s+\Z//; # chompr
    ($aseqno, $name, @rest) = split(/\t/, $line);
    if (! defined($ders{$aseqno})) { 
        $rseqno = $DSEQNO;

        if (0) {
        } elsif ($name =~ m{(First|Second|Third|Fourth|Fifth|Sixth|Seventh|\d+th) differences? (of|are|give)[^A]*(A\d{6})}) {
            $level = lc($1);
            $rseqno = $3;
            if ($level =~ m{[a-z]}) {
                $level = $levels{$level};
            }
        } # if $name 
        if (defined($ders{$rseqno})) { # implemented in jOEIS
            my $roffset = $ders{$rseqno}; # offset of $rseqno
            my $parm1 = "new $rseqno()";
            print join("\t", $aseqno, $callcode, $offset, $parm1, $roffset, $level, $parm4, substr($name, 0, 64)) . "\n";
        } else {
            print STDERR "$line\n";
        }
    } # Positions of
} # while <>
#--------------------------------------------
__DATA__
