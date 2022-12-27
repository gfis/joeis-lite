 #!perl

# Determine polarity for bisections
# @(#) $Id$
# 2022-12-24: renewed
# 2021-05-28, Georg Fischer
#
#:# Usage:
#:#  grep -Ei "section of A[0-9]+" $(COMMON)/joeis_names.txt \
#:# | perl bisect0.pl > seq4-format
#---------------------------------
use strict;
use integer;
use warnings;

my $debug = 0;
my $line;
my ($aseqno, $callcode, $offset, $superclass, $rseqno, $polar, $lista, $listr, $name);
my $cc = "bisect";
my @rest;
my $COMMON = "../../../OEIS-mat/common";
my $ofter_file = "$COMMON/joeis_ofter.txt";
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } elsif ($opt   =~ m{\-f}  ) {
        $ofter_file = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while options
my $terms;
my %ofters = ();
open (OFT, "<", $ofter_file) || die "cannot read $ofter_file\n";
while (<OFT>) {
    s{\s+\Z}{};
    ($aseqno, $offset, $terms) = split(/\t/);
    $terms = $terms || "";
    if ($offset < -1) { # offsets -2, -3: strange, skip these
    } else {
        $ofters{$aseqno} = $offset; # "$offset\t$terms";
    }
} # while <OFT>
close(OFT);
print STDERR "# $0: " . scalar(%ofters) . " jOEIS offsets and some terms read from $ofter_file\n";

while(<>) {
    s{\s+\Z}{}; # chompr
    $line = $_;
    $line =~ s{\..*}{}; # remove all behind 1st dot
    ($aseqno, $superclass, @rest) = split(/\t/, $line);
    $name = $rest[0];
    $name =~ m{(A\d+)}; 
    $rseqno = $1 || "";
    if (! defined($ofters{$aseqno})) { # nyi in jOEIS
        if (defined($ofters{$rseqno})) {
            $polar = -2; 
            if ($name =~ m{(even |odd |first |second |third |)bisection}i) { 
                $polar = substr(lc($1), 0, 1); 
                $polar =~ tr{eofst}{01102}; 
            }
            print        join("\t", $aseqno, $cc, -2, $rseqno, $polar, "",   "",   substr($name, 0, 64)) . "\n";
            #                                       parm1    parm2   parm3 parm4 parm5 
        } else {
            print STDERR join("\t", $aseqno, "?rseqno", -2, $rseqno, $name) . "\n";
        }
    } # nyi
} # while <>
#--------
__DATA__
