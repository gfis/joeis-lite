#!perl

# Extract parameters for jOEIS 
# eulerper.jpat (EulerTransformSequence(new PeriodicSequence(period),0))
# 2020-03-07, Georg Fischer
#
#:# Usage:
#:#   perl eulerper.pl $(COMMON)/cat25.txt > eulerper.gen
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $perlen = 0;
my $period = "";
my @periods = ();
my $aseqno = "A000000";
my $line = "";
while (<>) {
    $line = $_; 
    if (0) {
    } elsif ($line =~ m{Euler transform of period\s+(\d+)\s+(sequence\s+)?\[?([\d \,\-\.]+)}) { 
        ($perlen, $period) = ($1, $3);
        $period =~ s{\s}{}g; 
        $period =~ s{\,?\s*\.\.\.}{};
        if ($period !~ m{\A(\-?\d+)(\,\-?\d+)*\Z}) {
            @periods = ();
        } else {
        	@periods = split(/\,/, $period);
        }
        &output();
    }
} # while <>

sub output {
    $line =~ m{^\%\w (A\d+)}; 
    $aseqno = $1;
    $perlen = scalar(@periods);
    if ($perlen > 0) {
        print join("\t", $aseqno, "eulerper", 0, $perlen, join(",", @periods)) . "\n";
    }
}
__DATA__

