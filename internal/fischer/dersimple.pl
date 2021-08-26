#!perl

# Extract parameters for simple derived sequences Aseqno(n) = Rseqno(n+k) +-*/^% m
# @(#) $Id$
# 2021-08-21, Georg Fischer: copied from deris.pl
#
#:# Usage:
#:#     grep -E "\%[NF]" $(COMMON)/jcat25.txt \
#:#     | cut -b4 | sed -e "s/ /\t/" \
#:#     | perl dersimple.pl [-d debug] [-f ofter_file] > $@.tmp 2> $@.rest.tmp
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#:#     -f  file with aseqno, offset1, terms (default $(COMMON)/joeis_ofter.txt)
#:# Reads ofter_file for implemented jOEIS sequences with their offsets and first terms
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

my $debug = 0;
if (0 and scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $callcode = "dersimple";
my $ofter_file = "../../../OEIS-mat/common/joeis_ofter.txt";
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-cc}i) {
        $callcode   = shift(@ARGV);
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } elsif ($opt   =~ m{\-f}  ) {
        $ofter_file = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while options
#----------------
my $aseqno;
my $offset = 1;
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
my $VOID = "VOID";

my $line;
my $name;
my @parms; # records in joeis_names.txt
my $level; # of nesting for diffseq
my $rseqno; # aseqno of the referenced, underlying sequence
my $aofs; # offset for $aseqno
my $rofs; # offset for $rseqno
my $rshift; # expression is rseqno(n+shift)
my $op;
my $num;
my $op2;
my $num2;
my $is_ok;
my %ophash = 
    ( "+",   ".add("
    , "-",   ".subtract("
    , "*",   ".multiply("
    , "/",   ".divide("
    , "^",   ".pow("
    , "mod", ".mod("
    );
my %znames = qw (0 ZERO 1 ONE 2 TWO 3 THREE 4 FOUR 5 FIVE 6 SIX 7 SEVEN 8 EIGHT 9 NINE 10 TEN);
while (<>) {
    $line = $_;
    $line =~ s/\s+\Z//; # chompr
    ($aseqno, $name) = split(/\t/, $line);
    $aofs = 0; # $ofters{$aseqno};
    $name = $name || "";
    $callcode = "dersimple";
    $rseqno = $VOID; # assume suppression of the generation of this record
    $is_ok = 0; # assume referenced seq not yet implemented
    if ($line =~ m{apparent|empirical|conject}i) {
        # ignore the unproven
    } elsif ($name =~ m{\A(a\(n\) *\= *)?(A\d+)(\(n([\+\-]\d+)?\))? *([\*\/\+\-\^]|mod) *(\d+|n) *(([\*\/\+\-\^]|mod) *(\d+|n) *)?(\.|\Z)}) {
        #                 1              2     3   4                 5                   6        78                   9
        ($rseqno, $rshift, $op, $num, $op2, $num2) = ($2, $4 || 0, $5, $6, $8 || "", $9 || "");
        $is_ok = defined($ofters{$rseqno});
        if ($is_ok) {
            $rofs = $ofters{$rseqno};
            if ($num  =~ s{n}{mN}g) {
                $callcode = "dersimpln";
            }
            if ($num2 =~ s{n}{mN}g) {
                $callcode = "dersimpln";
            }
            $op  = &norm_op($op,  $num);
            $op2 = &norm_op($op2, $num2);
        }
    }
    if ($is_ok == 1) { # rseqno is implemented in jOEIS
        print join("\t", $aseqno, $callcode, $aofs, $rseqno, "$op$op2", $rofs - $rshift, "", $name) . "\n";
        #                                           parm1    parm2      parm3
    } # conditional output
} # while <>
#----
sub norm_op {
    my ($op, $num) = @_;
    if ($op ne "") {
        $op = $ophash{$op} . "$num)";
        $op =~ s{(multiply|divide)\(2\)}{${1}2\(\)};
        $op =~ s{pow\(2\)}{square\(\)};
        if ($op =~ m{mod\((\d+|mN)\)}) {
            my $mod = $1;
            if ($mod eq "mN") {
                $op =~s{mod\(mN\)}    {mod\(Z\.valueOf\($mod\)\)};
            } elsif ($mod <= 10) {
                $op =~s{mod\((\d+)\)} {mod\(Z.$znames{$mod}\)};
            } else {
                $op =~s{mod\((\d+)\)} {mod\(Z\.valueOf\($mod\)\)};
            }
        }
    }
    return $op;
} # norm_op
#----------------
__DATA__
