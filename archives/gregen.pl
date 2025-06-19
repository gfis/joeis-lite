#!perl

# generate gregen records: aseqno, cc, offset and all parms concatenated by literal "\\t" 
# @(#) $Id$
# 2025-06-19, Georg Fischer
#
#:# Usage:
#:#     perl gregen.pl [-d mode] input.seq4 > output.txt
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#:#     perl gregen.pl -c > gregen.create.sql
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
my $create = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } elsif ($opt   =~ m{\-c}  ) {
        $create = 1;
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while options
my $MAX = 21000;
if ($create) {
  print <<"GFis";
--  Table for joeis-lite: history of all generated seq4 records
--  \@(#) \$Id\$ 
--  2025-06-19: Georg Fischer
--
DROP    TABLE  IF EXISTS gregen;
CREATE  TABLE            gregen
    ( aseqno   VARCHAR(10) NOT NULL  -- A322469
    , callcode VARCHAR(48)           -- cfsnum
    , offset1  VARCHAR(16)           -- offset1
    , parms    VARCHAR($MAX)
    , PRIMARY KEY(aseqno)
    );
COMMIT;
GFis
  exit(0);
}
my $line;
while (<>) {
  $line = $_;
  $line =~ s/\s+\Z//; # chompr 
  my ($aseqno, $cc, $offset1, @rest) = split("\t", $line);
  my $parms = substr(join("\\t", @rest), 0, $MAX);
  print join("\t", $aseqno, $cc, $offset1, join("\\t", @rest)) . "\n";
} # while <>
__DATA__
A228074	wraptr2	0	new A000045()	new A001477()							A Fibonacci-Pascal triangle read by rows: T(n,0) = Fibonacci(n), T(n,n) = n and for n > 0: T(n,k) = T(n-1,k-1) + T(n-1,k), 0 < k < n.
A228196	wraptr2	1	new A000290()	new A155559()							A triangle formed like Pascal's triangle, but with n^2 on the left border and 2^n on the right border instead of 1.
A230448	wraptr2	0	"1"	new A226205()							T(n, k) = T(n-1, k-1) + T(n-1, k) with T(n, 0) = 1 and T(n, n) = A226205(n+1), n >= 0 and 0 <= k <= n.
