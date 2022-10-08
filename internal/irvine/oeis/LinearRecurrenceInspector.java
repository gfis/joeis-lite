package irvine.oeis;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.nio.channels.Channels;

import irvine.math.z.Z;
import irvine.oeis.recur.HolonomicRecurrence;

/**
 * Generate parameters for {@link HolonomicRecurrence}
 * from a file containing tabseparated tuples (A-number, callcode, offset, known linear recurrence signature).
 * Try to use as few initial terms as possible.
 * The output file has two types of records:
 * <pre>
 * A-number tab holos tab offset1 tab matrix tab inits tab dist tab gftype
 * # A-number signature not matching n terms
 * </pre>
 * @author Georg Fischer
 */
public final class LinearRecurrenceInspector {

  /** Empty constructor */
  private LinearRecurrenceInspector() { 
  }

  protected static int sDebug = 0;

  /**
   * Main program.
   * @param args command line arguments: [-d debug] [-n noterms] [-f {-|filename}] [---help]
   * <ul>
   * <li>-d level debugging level (default 0=none, 1=some, 2=more)</li>
   * <li>-f input file or "-" for STDIN, contains tab-separated tuples: (A-number, callcode, offset1, signature, 0, superclass)</li>
   * <li>-n use and compare so many terms of the underlying sequence (default: 16)</li>
   * </ul>
   */
  public static void main(final String[] args) {
    final String srcEncoding = "UTF-8"; // Encoding of the input file
    sDebug = 0;
    String fileName = "-";
    int noTerms = 16;
    int iarg = 0;
    while (iarg < args.length) { // consume all arguments
      final String opt = args[iarg ++];
      try {
        if (false) {
        } else if (opt.equals    ("-d")     ) {
          sDebug  = Integer.parseInt(args[iarg++]);
        } else if (opt.equals    ("-f")     ) {
          fileName = args[iarg ++];
        } else if (opt.equals    ("-n")     ) {
          noTerms = Integer.parseInt(args[iarg++]);
        } else if (opt.indexOf   ("-h") >= 0) {
          System.out.print("Usage: java irvine.oeis.LinearRecurrenceInspector [-d debug] [-i initerms] [-n noterms] [-f {-|filename}] [---help]\n"
              + "    -d debugging mode: 0=none (default), 1=some, 2=more\n"
              + "    -f input file or \"-\" for STDIN, contains tab-separated tuples: (A-number, callcode, offset1, signature, 0, superclass)\n"
              + "    -n use and compare so many terms of the underlying sequence (default: 24)\n"
              );
          return;
        } else {
          System.err.println("**LinearRecurrenceInspector: invalid option: \"" + opt + "\"");
        }
      } catch (Exception exc) { // take default
      }
    } // while args
    String line; // current line from text file
    try {
      try (final BufferedReader lineReader = fileName.length() <= 0 || fileName.equals("-")
        ? new BufferedReader(new InputStreamReader(System.in, srcEncoding))
        : new BufferedReader(Channels.newReader(new FileInputStream(fileName).getChannel(), srcEncoding))) {
        while ((line = lineReader.readLine()) != null) { // read and process lines
          if (line.matches("A[0-9]+\t.*")) { // start with aseqno tab
            final String[] parms = line.split("\\s+");
            int iparm = 0;
            final String aNumber = parms[iparm++];
            iparm++; // skip callcode
            final int offset = Integer.parseInt(parms[iparm++]);
            String signature = parms[iparm++]; // this is the signature as used by the OEIS and Mathematica: a(n-1), a(n-2) ...
            signature = signature.replaceAll("[^\\,\\-0-9]", "");
            final String[] sigs = signature.split("\\,");
            final int sigLen = sigs.length;
            final StringBuilder matrix = new StringBuilder("[0"); // optional constant in the recurrence
            int im = 0;
            for (int isig = sigLen - 1; isig >= 0; --isig) { // reverse the signature
              matrix.append(',');
              matrix.append(sigs[isig]);
            }
            matrix.append(",-1]"); // for a(n)
            
            try {
              final Sequence seq = SequenceFactory.sequence(aNumber); // must exist
              if (seq == null) {
                System.out.println("# " + aNumber + " not yet implemented in jOEIS");
              } else {
                final StringBuilder inits = new StringBuilder();
                final Z expects[] = new Z[sigLen + noTerms];
                int it = 0; 
                while (it < expects.length) {
                  expects[it] = seq.next();
                  if (expects[it] == null) {
                    System.out.println("# " + aNumber + ": " + (it - 1) + " terms are too few for signature " + signature + ")");
                    it = expects.length; // break loop
                  }
                  ++it;
                }
                if (sDebug >= 2) {
                  System.out.print("expects: ");
                  for (it = 0; it < expects.length; ++it) {
                    if (it >= 1) {
                    	System.out.print(",");
                    }
                    System.out.print(expects[it]);
                  }
                  System.out.println();
                }
                boolean busy = true;
                it = 0;
                while (busy && it < expects.length - 1) {
                  if (it > 0) {
                    inits.append(',');
                  }
                  inits.append(expects[it]);
                  final HolonomicRecurrence hr = new HolonomicRecurrence(offset, matrix.toString(), inits.toString(), 0);
                  boolean matches = true;
                  int ic = 0; 
                  while (matches && ic < expects.length) {
                    matches = hr.next().equals(expects[ic]);
                    ++ic;
                  }
                  if (matches) { // has matched all expected terms
                    busy = false;
                  }
                  ++it;
                }
                if (sDebug >= 1) {
                  System.out.println("make runholo A=" + aNumber + " OFF=" + offset + " MATRIX=\"" + matrix.toString() + "\" INIT=\"" + inits.toString() + "\"");
                }
                if (busy) {
                  System.out.println("# " + aNumber + ": first " + (it - 1) + " terms did not match the recurrence"); 
                } else { // has matched all expected terms
                  System.out.println(aNumber + "\tholos\t" + offset + "\t" + matrix.toString() + "\t" + inits.toString() + "\t0");
                }
              }
            } catch (Exception exc) {
              System.out.println("#?? " + aNumber + ": " + exc.getMessage());
              exc.printStackTrace();
            }
          } // is not a comment
        } // while ! eof
      }
    } catch (final Exception exc) {
      System.err.println(exc.getMessage());
    }
  }
}
