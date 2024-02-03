#!perl

# DirectSequence enabling
# @(#) $Id$
# 2024-02-03, Georg Fischer copied from change.pl
#
# Usage:
#   perl endirect.pl aseqno ...
#------------------------------------------------------------------
use strict;

my $debug;
while (scalar(@ARGV) > 0 && ($ARGV[0] =~ m{\A\-})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt =~ m{\A\-d}) {
        $debug = shift(@ARGV);
    } else {
        print STDERR "# unknown option $opt\n";
    }
} # while $opt

while (scalar(@ARGV) > 0) {
    my $aseqno = shift(@ARGV);
    my $apa = lc(substr($aseqno, 0, 4));
    my $srcfile = "../../../joeis/src/irvine/oeis/$apa/$aseqno.java";
    open (SRC, "<", $srcfile) || die "# cannot read \"$srcfile\"\n";
    my $buffer = "";
    my $count = 0;
    my $state = 1;
    while (<SRC>) {
        my $line = $_;
        if (0) {
        } elsif ($state == 1) { 
            if ($line =~ m{\Aimport +irvine\.oeis\.}) {
                $state = 2;
                $buffer .= "import irvine.oeis.DirectSequence;\n";
            }
        } elsif ($state == 2) {
            if ($line =~ m{\Apublic +class}) {
                $state = 3;
                $line =~ s{\{}{implements DirectSequence \{};
            }
        } elsif ($state == 3) {
            if ($line =~ m{\@Override}) {
                $state = 4;
                $buffer .= <<'GFis';
  @Override
  public Z a(final Z n) {
    return n;
  }

  @Override
  public Z a(final int n) {
    return a(Z.valueOf(n));
  }

GFis
            }
        }
        $buffer .= $line;
    } # while <SRC>
    close(SRC);
    my $tarfile = "./manual/$aseqno.java";
    open (TAR, ">", $tarfile) || die "# cannot write \"$tarfile\"\n";
    print TAR $buffer;
    close(TAR);
} # while ARGS
