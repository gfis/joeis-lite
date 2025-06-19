#!perl

# generate seq5 records: archive name + seq4 contents
# @(#) $Id$
# 2025-06-19, Georg Fischer
#
#:# Usage:
#:#     find archives -t f -iname "*.gen" \
#:#     | perl makeseq5.pl [-d mode] > output.seq5
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
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
my $do_generate = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } elsif ($opt   =~ m{\-g}  ) {
        $do_generate = 1;
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while options

my $line;
my $name;
my $path; # input path and filename
my $date;
while (<>) {
  $line = $_;
  $line =~ s/\s+\Z//; # chompr
  $path = $line;
  my ($archive, $tgz, $internal, $fischer, $gen) = split("\/", $path);
  if ($tgz =~ s{\.tgz\Z}{}) {
    #               1                 2      21
    if ($tgz =~ s{\.(\d{4}\-\d\d\-\d\d(\.\d\d)?)\Z}{}) {
      $date = $1;
      print "# seq5: $date\t  $tgz\n";
      if ($do_generate) {
        &generate();
      }
    } else {
      print STDERR "# bad date in name: $line\n";
    }
  } else {
    print STDERR "# bad tgz name: $line\n";
  }
} # while <>
#----
sub generate {
  open(SRC, "<", $path) || die "cannot read $path\n";
  while (<SRC>) {
    s/\s+\Z//; # chompr
    my $src = $_;
    if ($src =~ m{\AA\d{6}\t[a-zA-Z0-9_\-\.]+\t\-?\d+\t}) { # seq4 format with callcode, offset
      print "$date\t$src\n";
    }
  } # while SRC
  close(SRC);
} # generate
#----------------
__DATA__
archives/wparts.2025-03-11.22.tgz/internal/fischer/wparts.gen
archives/wraptr.2021-10-17.19.tgz/internal/fischer/wraptr.gen
archives/wroot.2021-07-03.21.tgz/internal/fischer/wroot.gen
archives/zbasex.2021-07-20.16.tgz/internal/fischer/zbasex.gen