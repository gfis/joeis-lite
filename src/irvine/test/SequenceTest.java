/* Test a single sequence, and write a b-file
 * @(#) $Id$
 * 2020-10-31: read dead.lst
 * 2019-05-11: renamed from ../oeis/SequenceFactory.java
 * 2019-05-09, Georg Fischer: joeis-lite version, writes b-file format
 * 2019-01-01: Sean Irvine, class SequenceFactory
 */
package irvine.test;

import java.io.BufferedOutputStream;
import java.io.FileDescriptor;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.util.HashSet;
import java.util.Set;
import java.text.SimpleDateFormat;
import java.util.Date;

import irvine.math.z.Z;
import irvine.oeis.DeadSequence;
import irvine.oeis.Sequence;
import irvine.oeis.SequenceFactory;
import irvine.util.string.Casing;
import irvine.util.string.StringUtils;

/**
 * Print the terms of a single sequence, possibly in b-file format.
 * @author Georg Fischer
 */
public final class SequenceTest {

  private static Set<String> sDead = null;
  private static final Sequence DEAD_SEQUENCE = new DeadSequence();

  private static synchronized boolean isDead(final String aNumber) {
    if (sDead == null) {
      try {
        sDead = new HashSet<>(StringUtils.suckInWords(SequenceFactory.class.getResourceAsStream("/irvine/oeis/dead.lst"), Casing.NONE));
      } catch (final IOException e) {
        throw new RuntimeException(e);
      }
    }
    return sDead.contains(aNumber);
  }

  private SequenceTest() { }

  /**
   * Return the sequence for the specified id. The sequence is not
   * known then <code>UnsupportedOperationException</code> is thrown.
   *
   * @param seqId sequence identifier in the form <code>A000001</code>
   * @return sequence for id
   * @exception UnsupportedOperationException for an unknown
   * <code>seqId</code>.
   */
  public static Sequence sequence(final String seqId) {
    if (seqId != null && seqId.length() > 1 && seqId.charAt(0) == 'A') {
      final String canonicalId;
      if (seqId.length() < 7) {
        // Pad out number to correct format
        canonicalId = "A000000".substring(0, 8 - seqId.length()) + seqId.substring(1);
      } else {
        canonicalId = seqId;
      }

      try {
        return (Sequence) Class.forName("irvine.oeis.a" + canonicalId.substring(1, 4) + '.' + canonicalId).newInstance();
      } catch (final ClassNotFoundException | IllegalAccessException | InstantiationException e) {
        if (isDead(canonicalId)) {
          return DEAD_SEQUENCE;
        }
        System.err.println(e.getMessage());
        e.printStackTrace();
        throw new UnsupportedOperationException();
      }
    }
    throw new UnsupportedOperationException();
  } // sequence

  /**
   * Generate terms from specified sequence, writing a b-file with one term per line
   * @param args sequence identifier, number of terms, offset1
   */
  public static void main(final String[] args) {
    if (args == null || args.length == 0) {
      System.out.print("Usage: SequenceTest [-a aseqno] [-n termno] [-o offset] [-bf] \n"
          + "    -a  A-number\n"
          + "    -n  number of terms to be output (default: max. 260 characters on the line)\n"
          + "    -o  offset1 (default: 1)\n"
          + "    -bf output b-file format (default: a single line)\n"
          );
    } else {
      int iarg = 0;
      String aseqno = "A322469";
      boolean genBFile = false;
      Sequence seq = null;
      Z z = Z.ZERO;
      int nterms  = -1; // undefined so far
      int offset1 = 1;
      while (iarg < args.length && args[iarg].startsWith("-")) {
        String arg = args[iarg ++];
        if (false) {
        } else if (arg.startsWith("-a")) {
          aseqno = args[iarg ++];
        } else if (arg.startsWith("-b")) {
          genBFile = true;
        } else if (arg.startsWith("-n")) {
          try {
            nterms = Integer.parseInt(args[iarg ++]);
          } catch (Exception exc) { // ignore and take default
          }
        } else if (arg.startsWith("-o")) {
          try {
            offset1 = Integer.parseInt(args[iarg ++]);
          } catch (Exception exc) { // ignore and take default
          }
        } else {
          System.err.println("SequenceTest: unknown option \"" + args[iarg] + "\"");
        }
      } // while iarg

      if (genBFile && nterms < 0) {
        nterms = 32;
      }
      int restLen = 260; // maximum length for OEIS data section
      if (nterms < 0) {
        nterms = 29061947; // very high
      } else {
        restLen = 29061947; // very high
      }
      int iterm = offset1;
      boolean generated = false;
      try {
        seq = sequence(aseqno);
        if (! genBFile) {
          int busy = 2;
          while ((z = seq.next()) != null && restLen >= 0 && iterm <= nterms) {
            generated = true;
            final String zstr = z.toString();
            restLen -= zstr.length();
            if (restLen >= 0) {
              if (busy == 1) {
                System.out.print(", ");
              }
              busy = 1;
              System.out.print(zstr);
              System.out.flush();
            } else {
              busy = 0;
            }
            ++iterm;
          } // while
          System.out.println();
        } else { // write b-file format
          final int ilast = iterm + nterms - 1;
          System.out.print("# Table of n, a(n) for n = " + offset1 + ".." + ilast + "\n");
          System.out.print("# Generated by Georg Fischer with jOEIS, "
              + (new SimpleDateFormat("MMM dd yyyy")).format(new java.util.Date()) + "\n");
          while (iterm <= ilast && (z = seq.next()) != null) {
            generated = true;
            System.out.print(String.valueOf(iterm) + " " + z.toString() + "\n"); // b-file format
            iterm ++;
            System.out.flush();
          } // while iterm
          System.out.print("\n\n"); // convention is: one additional newline
          System.out.flush();
        } // b-file format
      } catch (final UnsupportedOperationException e) {
        if (generated) {
          System.err.print("Implementation limits exceeded, cannot generate further terms for " + args[0] + "\n" + e.getMessage() + "\n");
        } else {
          System.err.print(aseqno + "() could not be constructed\n");
        }
      } catch (final Exception e) {
        // Catch nasty shutdown exception from Apfloat and just ignore it
        if (! "Shutdown in progress".equals(e.getMessage())) {
          throw e;
        }
      }
    } // with arguments
  } // main
} // SequenceTest
