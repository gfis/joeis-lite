#!perl

# Join pairs of A-numbers in the result of partralr_eval
# @(#) $Id$
# 2022-10-09, Georg Fischer
#
#:# Usage:
#:#   perl partra_join.pl [-d debug] [-lr|-rl] [-md] [-t] patralr_eval.2.tmp | tee output.tmp
#:#       -d  debug mode, 0=none (default), 1=some, 2=more
#:#       -lr LeftSide, Name
#:#       -s  size of data string to be searched (default: 128)
#:#       -rl Name, RightSide
#:#       -md MarkDown table format
#:#       -t  with tab, search begins at start of bfdata.data (default: anywhere in bfdata.data)
#---------------------------------
use strict;
use integer;
use warnings;

my $bfdata = "../../../OEIS-mat/common/bfdata.txt";
my $debug  = 0;
my $lr = "lr";
my $md = 0;
my $tab = "";
my $size = 128;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{\A\-d\Z}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{lr}) {
        $lr        =   "lr";
    } elsif ($opt  =~ m{md}) {
        $md        = 1;
    } elsif ($opt  =~ m{rl}) {
        $lr        =   "rl";
    } elsif ($opt  =~ m{s}) {
        $size      = shift(@ARGV);
    } elsif ($opt  =~ m{t}) {
        $tab       =   "\t";
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
print "start, debug=$debug, md=$md, lr=$lr\n";
my $oseqno = "";
my ($aseqno, $nseqno, $rseqno, $callcode, $offset, $data, $name);
while(<>) {
    s{\s+\Z}{}; # chompr
    my $line = $_;
    if ($debug >= 2) {
        print "line: $line\n";
    }
    ($nseqno, $callcode, $offset, $data) = split(/\t/, $line);
    if ($nseqno ne $oseqno) {
        &output();
        $oseqno = $nseqno;
        $aseqno = $nseqno;
    } 
    if (0) {
    } elsif ($callcode =~ m{(Left|Right)Side}) {
        $data = substr($data, 0, $size);
        my $cmd = "grep -P \"" . ($tab ne "" ? "\\t" : "") . "$data\" $bfdata";
        if ($debug >= 1) {
            print "# cmd=$cmd\n";
        }
        my @greps = split(/\r?\n/, `$cmd`);
        $rseqno = "??";
        if (scalar(@greps) > 0) {
            $rseqno = substr($greps[0], 0, 7);
        }
    } elsif ($callcode =~ m{Name}) {
        $name = $data;
    }
} # while <>
&output();
#----
sub output {
    if ($oseqno ne "") {
        if ($md) { # markdown table row
            print "| [OEIS](https://oeis.org/search?q=" . ($rseqno ne "??" ? "id:$rseqno\%7C" : "") 
                . "id\%3A$aseqno\&fmt=short) | $rseqno | $aseqno | | 0 | <code></code> |\n";
        } else {
            print join("\t", $aseqno, "partra$lr", $offset, $rseqno, $name) . "\n";
        }
    } else {
        if ($md) { # header
            print <<'GFis';
| Data | Generator  | Table  | CompInv | Shift | Maple Function  |
| ---  | ---        | ---    | --- | ---  |---    |               
GFis
        } # $md header
    }
}
__DATA__
A337890 LeftSide        6       1,2,3,4,5,6
A337890 Name    2       Array read by descending antidiagonals: T(n,k) is the number of achiral colorings of the
A337891 LeftSide        6       1,2,3,4,5,6
A337891 Name    2       Array read by descending antidiagonals: T(n,k) is the number of oriented colorings of the
