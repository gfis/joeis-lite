#!perl

# Extract parameters for jOEIS xfmpad.jpat (transform of a PaddingSequencein)
# 2020-09-22, Georg Fischer
#
#:# Usage:
#:#   perl xfmpad.pl $(COMMON)/cat25.txt > xfmpad.gen
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $perlen = 0;
my $period = "";
my @periods = ();
my $line;
my $tletter;
my $aseqno;
my $callcode = "xfmpad";
my $offset = 0;
my $name;
my @parms; # records in joeis_names.txt
my $level; # of nesting for diffseq
my $padlist;

while (<>) {
    s/\s+\Z//; # chompr
    $line = $_;
    my $tletter;
    ($tletter, $aseqno, $name) = split(/\t/, $line);
    my $isok = 0; # assume referenced seq not yet implemented
    if ($line =~ m{apparent|empirical|conject}i) {

    } elsif ($name =~ m{[Bb]inomial transform of ([\-\d\{\[\(][^a-zA-Z\=\;\:\<\/]+)}) {
        $padlist = $1;
        $padlist =~ s{ }{}g;
        if (0) {
        } elsif ($padlist =~ m{\(}) {
            $padlist =~ s{\(([^\)]+)\).*}{$1};
        } elsif ($padlist =~ m{\[}) {
            $padlist =~ s{\[([^\]]+)\].*}{$1};
        } elsif ($padlist =~ m{\{}) {
            $padlist =~ s{\{([^\}]+)\}.*}{$1};
        } else {
            $padlist =~ s{\.\..*}{\.\.\.};
        }
        $parms[0] = $offset;
        $parms[1] = "BinomialTransformSequence";
        for (my $iparm = 2; $iparm < 9; $iparm ++) {
            $parms[$iparm] = "";
        }
        $parms[9] = substr($name, 0, 128);
        $padlist =~ s{[^0-9\,\.\- ]}{}g;
        if ($padlist =~ m{(\,\-?\d+)\,?\.\.\.\Z}) {
            my $right = substr($1, 1);
            $isok = 1;
            $padlist =~ s{\,$right\,\..*}{};
            $padlist =~ s{\.}{}g;
            $parms[3] = "super(new PaddingSequence(new long[] { $padlist }, new long[] { $right }), 0);"
        }
    }
    if ($isok) {
        print join("\t", $aseqno, $callcode, join("\t", @parms)) . "\n";
    } else {
        print STDERR join("\t", $aseqno, $callcode, $padlist, $name) . "\n";
    }
} # while <>
#--------
__DATA__
