#!perl

# Read a list of A-numbers and extract the constructors (and any additional code) pack all sources into one file
# @(#) $Id$ 
# 2026-11-15, Georg Fischer:copied from ../reflect/queue.pl; *EFF=5
#
#:# Usage:
#:#   perl extract_super.pl [-d debug] [-cc callcode] [-s srcdir] listfile > outfile
#:#       -cc callcode code for the pattern to be used
#:#       -of cut-off a leading offset
#:#       -s  main source directory qualifier: joeis (default) or joeis-lite
#:#       listfile has tsv fields aseqno, ...
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
my $debug      = 0;
my $main_src   = "joeis";
my $cc         = "callcode";
my $cut_offset = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{cc}) {
        $cc        = shift(@ARGV);
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{of}) {
        $cut_offset = 1;
    } elsif ($opt  =~ m{s}) {
        $main_src  = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $srcroot = "../../../../$main_src/src/irvine/oeis";
my $pack_count = 0;
my $aseqno = "";
my $offset = 0;
my @rest;

while (<>) { # read inputfile
    s{\s+\Z}{}; # chompr
    my $line = $_;
    next if ($line !~ m{\AA\d+});
    ($aseqno, @rest) = split(/\s+/, $line);
    &pack1($aseqno);
} # while <>
#----
sub pack1 { 
    my ($aseqno) = @_;
    my $adir = lc(substr($aseqno, 0, 4));
    my $srcname = "$srcroot/$adir/$aseqno.java";
    if (! open(SRC, "<", $srcname)) {
        print STDERR "#** cannot read $srcname\n";
        return; # skip nonexisting source file
    }
    my $buffer;
    my $read_len = 100000000; # 100 MB
    read(SRC, $buffer, $read_len);
    close(SRC);
    $pack_count ++;
    if ($pack_count % 256 == 0) {
        print STDERR "# +$pack_count: write $aseqno\n";
    } 
    #                        (1      1  2  2
    if ($buffer =~ m{super *\(([^\n]+)\n(.*)}) {
        my ($parm1, $parm2) = ($1, $2);
        $parm1 =~ s{\)\;\s*\Z}{};
        $offset = 0;
        if ($cut_offset == 1) {
            if ($parm1 =~ s{\A(\-?\d+)\, *}{}) { 
                $offset = $1;
            }
        }
        $parm2 =~ s{\}\s*\Z}{};
        print join("\t", $aseqno, $cc, $offset, $parm1, $parm2) . "\n";
    }
} # pack1
__DATA__
# Starting report at 2022-08-16 15:32:35
A002162 1 -> 0  DecimalExpansionSequence
A002285 1 -> 0  DecimalExpansionSequence
A002389 1 -> 0  DecimalExpansionSequence
A002390 1 -> 0  DecimalExpansionSequence
A002580 0 -> 1  DecimalExpansionSequence
A002794 1 -> 0  A030125
A002795 1 -> 0  A002794
A003077 1 -> 0  DecimalExpansionSequence
A003676 1 -> -33    DecimalExpansionSequence
