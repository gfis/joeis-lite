/*  Reads a list of A-numbers and appends attributes of the sequences
 *  @(#) $Id$
 *  2022-10-09, Georg Fischer: copied from ConstantReflector
 */
package irvine.oeis;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Method;
import java.nio.channels.Channels;
import java.nio.charset.StandardCharsets;

import irvine.math.z.Z;
import irvine.oeis.cons.ContinuedFractionSequence;
import irvine.oeis.cons.DecimalExpansionSequence;
import irvine.oeis.PseudoSequence;

/** Reads a list of A-numbers and appends attributes for the sequences.
 *  The output file is tab-separated: aseqno, callcode, offset, parm1, parm2 ...
 *  @author Dr. Georg Fischer
 */
public class ConstantReflector {
  /**
   * A-number of sequence currently tested
   */
  private String mAseqno;

  /**
   * Debugging level: 0 = none, 1 = some, 2 = more
   */
  private int mDebug;

  /**
   * Number of digits behind the decimal dot
   */
  private int mDecimalPlaces;

  /**
   * Encoding of the input file
   */
  private final String mSrcEncoding = "UTF-8";;

  /**
   * No-args Constructor
   */
  public ConstantReflector() {
    mDebug = 0;
    mDecimalPlaces = 32;
  } // no-args Constructor

  /**
   * Processes lines of the form
   * @param fileName name of input file or "-" for STDIN, with tab-separated tuples (aseqno, callcode, offset1).
   * The following <code>callCode</code>s are processed:
   * <ul>
   * <li><code>cofr</code> - determine the underlying {@link DecimalExpansionSequence} for a {@link ContinuedFractionSequence}
   * <li><code>exp</code> - compute the constant up to determine the prefixed initial terms (new, with shorten)</li>
   * <li><code>holoh</code> - determine the prefixed initial terms (old version)</li>
   * <li><code>holop</code> - return the parameters of the sequence (below in {@link #processFile})<li>
   * <li><code>holor</code> - try to evaluate the recurrence backwards</li>
   * <li><code>holos</code> - evaluate the recurrence <code>numTerms</code> times</li>
   * </ul>
   */
  public void processBatch(final String fileName) {
    try {

      try (final BufferedReader lineReader =  fileName == null || fileName.length() <= 0 || fileName.equals("-")
        ? new BufferedReader(new InputStreamReader(System.in, mSrcEncoding))
        : new BufferedReader(Channels.newReader((new FileInputStream(fileName)).getChannel(), mSrcEncoding))
      ) {
        String line;
        while ((line = lineReader.readLine()) != null) { // read and process lines
          if (line.startsWith("A")) { // valid A-number
            final String[] parts = new String[8];
            final String[] elems = line.split("\\t", -1); // include trailing empty strings
            int ipart = 0;
            if (elems.length >= parts.length) {
              System.arraycopy(elems, 0, parts, 0, parts.length);
            } else { // elems has fewer
              System.arraycopy(elems, 0, parts, 0, elems.length);
              for (ipart = elems.length + 1; ipart < parts.length; ++ipart) {
                parts[ipart] = "";
              }
            }
            ipart = 0; // leave aseqno and callCode
            mAseqno = parts[ipart++];
            final String callCode = parts[ipart++];
            final int offset1 = Integer.parseInt(parts[ipart++]); 
            final String className = "irvine.oeis.a" + mAseqno.substring(1, 4) + '.' + mAseqno;
            boolean changed = false; // assume that the record will not be changed
            try {
              if (false) {
              } else if (callCode.startsWith("cofr")) {
                final ContinuedFractionSequence cfSeq = (ContinuedFractionSequence) Class.forName(className).getDeclaredConstructor().newInstance();
                DecimalExpansionSequence deSeq = null; // ??? cfSeq.getBaseSequence();
                if (deSeq != null) {
                  final String aName = deSeq.getClass().getName().replaceAll("irvine\\.oeis\\.a\\d+\\.", "");
                  if (aName.matches("A\\d+")) {
                    changed = true;
                    parts[ipart++] = aName;
                  }
                }
              } else if (callCode.startsWith("exp")) {
                final DecimalExpansionSequence deSeq = (DecimalExpansionSequence) Class.forName(className).getDeclaredConstructor().newInstance();
                if (deSeq != null) {
                  if (deSeq.getBase() == 10) {
                    final StringBuilder buffer = new StringBuilder(1024);
                    boolean busy = true;
                    int k = 0; 
                    while (busy && k < mDecimalPlaces) {
                      final Z term = deSeq.next();
                      if (term != null) {
                        buffer.append(term.toString());
                      } else {
                        busy = false; // premature end
                      }
                      ++k;
                    }
                    changed = true;
                    parts[ipart++] = buffer.toString();
                  } else {
                    System.err.println("# " + mAseqno + ": base " + deSeq.getBase() + " expansion");
                  }
                }
              } else { // ignore
              } // end of switch for callCodes

              if (changed) {
                for (int kpart = 0; kpart < ipart; ++kpart) { // print a tab-separated record
                  if (kpart > 0) {
                    System.out.print("\t");
                  }
                  System.out.print(parts[kpart]);
                } // for kpart
                System.out.println();
              }
            } catch (final Exception exc) {
              System.err.println("# cannot construct " + className + ", exception: " + exc.getMessage());
              exc.printStackTrace();
            }
          } else { // commented out, empty ...
            // ignore lines without A-numbers
          }
        } // while ! eof
      }
    } catch (final Throwable exc) {
      System.err.println("FATAL - cannot read \"" + fileName + "\" - " + exc.getMessage());
    } // try
  } // processBatch

  /**
   * Processes the commandline arguments
   * @param args commandline arguments:
   * <ul>
   * <li>-d level debugging level: 0=none, 1=some, 2=more (default: 0)</li>
   * <li>input filename or "-" for STDIN</li>
   * </ul>
   */
  public void processArguments(final String[] args) {
    int iarg = 0;
    if (args.length == 0) {
      System.out.print("Usage: ConstantReflector [-d level] [-n digits] [-f]{- | filename}\n"
        + "    -d level      debugging level: 0=none, 1=some, 2=more (default: 0)\n"
        + "    -f filename   input file with (aseqno, callcode, offset) or \"-\" for STDIN\n"
        + "    -n digits     number of digits behind the decimal dot (default: 32)\n"
      );
      return;
    }
    String fileName = "-"; // default: read from STDIN
    while (iarg < args.length && args[iarg].startsWith("-")) {
      final String arg = args[iarg++];
      try {
        if (false) {
        } else if (arg.startsWith("-d")) {
          mDebug = Integer.parseInt(args[iarg++]);
        } else if (arg.startsWith("-f")) {
          fileName = args[iarg++];
        } else if (arg.startsWith("-n")) {
          mDecimalPlaces = Integer.parseInt(args[iarg++]);
        }
      } catch (final Throwable exc) {
        // silently assume default
      }

    } // while iarg
    if (iarg < args.length) {
      fileName = args[iarg++];
    }
    processBatch(fileName);
  } // processArguments

  /**
   * Main method
   * @param args command line arguments: filename or "-"
   */
  public static void main(final String[] args) {
    (new ConstantReflector()).processArguments(args);
  } // main

} // ConstantReflector
