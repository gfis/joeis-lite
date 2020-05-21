#!perl

# Replace the full notation by a call to the class for vertex id 1
# 2020-05-21, Georg Fischer
#
#:# Usage:
#:#   perl reduce_tile.pl infile > outfile
#
# Cf. tile_collect.pl
#----------------------------------------------------------------
use strict;
use integer;
use warnings;

my %hash = ();
while (<>) {
    s{\s+\Z}{}; # chompr
    my $line = $_;
    my ($aseqno, $callcode, $offset, $type_array, $zero, $ibase, $galid) = split(/\t/, $line);
    $galid = m{(\w+\.\d+)\.(\d+)};
    my $gal = $1;
    my $id  = $2;
    if ($id == 1) {
        $hash{$galid} = $aseqno;
    } else { # $id > 1
        if (defined($hash{"$gal.1"})) {
            my $rseqno = $hash{"$gal.1"};
        	$callcode =~ s{1}{6};
            $line = join("\t", ($aseqno, $callcode, $offset, &aseq($rseqno), $rseqno, $ibase, $galid)) . "\n";
        }
    } # $id > 1
    print "$line\n";
} # while <>
#----
sub aseq {
    my ($aseqno) = @_;
    return lc(substr($aseqno, 0, 4));
} # package
__DATA__
Example for the output:

A008486 tile1   0   6.6.6;A60+,A60+,A60+    0   0   Gal.1.1.1
A008576 tile1   0   8.8.4;A270+,A180+,A90+  0   0   Gal.1.2.1
A072154 tile1   0   12.6.4;A180-,A120-,A0-  0   0   Gal.1.3.1
A250122 tile1   0   12.12.3;A240+,A180+,A120+   0   0   Gal.1.4.1
A008574 tile1   0   4.4.4.4;A0+,A0+,A0+,A0+ 0   0   Gal.1.5.1
A008574 tile1   0   6.4.3.4;A60+,A300+,A120+,A240+  0   0   Gal.1.6.1
A008579 tile1   0   6.3.6.3;A240+,A300+,A240+,A300+ 0   0   Gal.1.7.1
A008706 tile1   0   4.4.3.3.3;A0+,A180+,A0+,A180+,A180+ 0   0   Gal.1.8.1
A219529 tile1   0   4.3.4.3.3;A90+,A270+,A90+,A270+,A180+   0   0   Gal.1.9.1
A250120 tile1   0   6.3.3.3.3;A60+,A300+,A180+,A120+,A240+  0   0   Gal.1.10.1
A008458 tile1   0   3.3.3.3.3.3;A0+,A0+,A0+,A0+,A0+,A0+ 0   0   Gal.1.11.1
A265035 tile1   0   12.6.4;A180-,A120-,B90+~~6.4.3.4;A270+,A210-,B120+,B240+    0   0   Gal.2.1.1
A265036 tile6   0   a265    A265035 1   Gal.2.1.2
A301287 tile1   0   12.12.3;B30+,A180+,B120+~~12.3.4.3;A240+,A330+,B90+,B270+   0   0   Gal.2.2.1
A301289 tile6   0   a301    A301287 1   Gal.2.2.2
A301293 tile1   0   4.4.4.4;A0+,A180+,A0+,B0+~~4.4.3.3.3;B0+,A0+,B0+,B180+,B180+    0   0   Gal.2.3.1

