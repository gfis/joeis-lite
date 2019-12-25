#!perl

# Extract single line MMA programs from cat25
# @(#) $Id$
# 2019-07-22, Georg Fischer
#
#:# usage:
#:#    grep -E "^%t" cat25.txt | perl mma_sinlge.pl [-d debug] > outputfile
#---------------------------------
use strict;
use integer;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday) = gmtime (time);
my $utc_stamp = sprintf ("%04d-%02d-%02dT%02d:%02d:%02d\z"
        , $year + 1900, $mon + 1, $mday, $hour, $min, $sec);

# get options
my $debug      =  0; # 0 (none), 1 (some), 2 (more)
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A\-})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt =~ m{\-d}) {
        $debug    = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while ARGV

my $oseqno = "";
my $nseqno;
my $oline;
my $nline;
my $count = 0;
my $stmt; 

while (<>) {
	s/\r?\n//; #chompr
	$nline = $_;
	$nseqno = substr($nline, 3, 7);
	if ($nseqno ne $oseqno) {
		&output;
		$count = 0;
		$oseqno = $nseqno;
	} 
	$stmt = substr($nline, 11);
	$stmt =~ s{^ +}{}; 
	$count ++;
} # while <>
&output;
#-------------
sub output {
	if ($count == 1 and ($stmt !~ m{\;}) and length($stmt) < 1000) {
		print "$oseqno\t$stmt\n";
	}
} # output
__DATA__
%t A154394 RealDigits[Log[11, 13], 10, 100][[1]] (* _Vincenzo Librandi_, Sep 01 2013 *)
%t A154479 RealDigits[Log[11, 14], 10, 100][[1]] (* _Vincenzo Librandi_, Sep 01 2013 *)
%t A154581 RealDigits[Log[11, 15], 10, 100][[1]] (* _Vincenzo Librandi_, Sep 01 2013 *)
%t A154801 RealDigits[Log[11, 16], 10, 100][[1]] (* _Vincenzo Librandi_, Sep 01 2013 *)
%t A154861 RealDigits[Log[11, 17], 10, 100][[1]] (* _Vincenzo Librandi_, Sep 01 2013 *)
%t A154954 RealDigits[Log[11, 18], 10, 100][[1]] (* _Vincenzo Librandi_, Sep 01 2013 *)
%t A155523 RealDigits[Log[11, 20], 10, 100][[1]] (* _Vincenzo Librandi_, Sep 01 2013 *)
%t A155678 RealDigits[Log[11, 21], 10, 100][[1]] (* _Vincenzo Librandi_, Sep 01 2013 *)
%t A155748 RealDigits[Log[11, 22], 10, 100][[1]] (* _Vincenzo Librandi_, Sep 01 2013 *)
%t A155831 RealDigits[Log[11, 23], 10, 100][[1]] (* _Vincenzo Librandi_, Sep 01 2013 *)
%t A155981 RealDigits[Log[11, 24], 10, 100][[1]] (* _Vincenzo Librandi_, Sep 01 2013 *)
%t A152748 RealDigits[Log[11, 2], 10, 100][[1]] (* _Vincenzo Librandi_, Sep 01 2013 *)
%t A152974 RealDigits[Log[11, 3], 10, 100][[1]] (* _Vincenzo Librandi_, Sep 01 2013 *)

