/*  Reads a list of A-numbers and appends the parameters of the sequences 
 *  @(#) $Id: RecurrenceReflector.java 744 2019-04-05 06:29:20Z gfis $
 *  2021-01-23, Georg Fischer: copied from BatchTest
 */
package irvine.test;
import irvine.math.z.Z;

import irvine.oeis.ContinuedFractionOfSqrtSequence;
import irvine.oeis.CoordinationSequence;
import irvine.oeis.CoxeterSequence;
import irvine.oeis.FiniteSequence;
import irvine.oeis.GeneratingFunctionSequence;
import irvine.oeis.HolonomicRecurrence;
import irvine.oeis.LinearRecurrence;
import irvine.oeis.PaddingSequence;
import irvine.oeis.PeriodicSequence;

import irvine.oeis.Sequence;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.Serializable;
import java.lang.NoSuchMethodException;
import java.lang.reflect.Method;
import java.nio.channels.Channels;
import java.nio.channels.ReadableByteChannel;
import java.util.ArrayList;

/** Reads a list of A-numbers and appends the parameters of the sequences.
 *  The output file is tab-separated: aseqno, callcode, offset, matrix, init, dist, gftype
 *  @author Dr. Georg Fischer
 */
public class RecurrenceReflector {
  public final static String CVSID = "@(#) $Id: RecurrenceReflector.java 744 2019-04-05 06:29:20Z gfis $";

  /** This program's version */
  private static String VERSION = "RecurrenceReflector V1.0";

  /** A-number of sequence currently tested */
  private String  aseqno;

  /** Debugging level: 0 = none, 1 = some, 2 = more */
  private int     debug;

  /** Encoding of the input file */
  private String  srcEncoding;
  
  /** No-args Constructor
   */
  public RecurrenceReflector() {
    // set default for variables and arguments
    debug          = 0;
    srcEncoding    = "UTF-8";
  } // no-args Constructor

  /**
   * Gets a String representation of a Z array.
   * @return a list of terms of the form "[0,1,1,2,1]".
   */
  public static String getVectorString(final Z[] vector) {
    final StringBuilder result = new StringBuilder(256);
    for (int j = 0; j < vector.length; ++j) {
      result.append(j == 0 ? '[' : ',');
      result.append(vector[j]);
    } // for j
    result.append(']');
    return result.toString();
  } // getVectorString()

  /**
   * Gets a String representation of an array of vectors for a periodic recurrence
   * @return a String of the form "[0,1,0,0,...0,-1]" with plen-1 zeroes.
   */
  public static String getPeriodicRecurrence(final int plen) {
    final StringBuilder result = new StringBuilder(256);
    result.append("[0,1");
    for (int j = 1; j < plen; ++j) {
      result.append(",0");
    } // for j
    result.append(",-1]");
    return result.toString();
  } // getPeriodicRecurrence()

  /** Processes lines of the form
   *  <pre>A040954\tcallcode\t...</pre>
   *  and reflect the corresponding sequence
   *  @param fileName name of input file or "-" for STDIN
   */
  public void processBatch(final String fileName) {
    int lineNo = 0;
    final StringBuilder buffer = new StringBuilder(1024);
    try {
      final Method contiNextMethod = new ContinuedFractionOfSqrtSequence      (0,0).getClass().getMethod("next");
      final Method finitNextMethod = new FiniteSequence                         (0).getClass().getMethod("next");
      final Method generNextMethod = new GeneratingFunctionSequence     (0,"1","1").getClass().getMethod("next");
      final Method holonNextMethod = new HolonomicRecurrence            (0,"1","1").getClass().getMethod("next");
      final Method lineaNextMethod = new LinearRecurrence(new long[0], new long[0]).getClass().getMethod("next");
      final Method paddiNextMethod = new PaddingSequence (new long[0], new long[0]).getClass().getMethod("next");
      final Method perioNextMethod = new PeriodicSequence             (new long[0]).getClass().getMethod("next");
      Method superNextMethod = null; // one of the above

      BufferedReader lineReader; // Reader for the input file
      String srcEncoding = "UTF-8"; // Encoding of the input file
      if (fileName == null || fileName.length() <= 0 || fileName.equals("-")) {
        lineReader = new BufferedReader(new InputStreamReader(System.in, srcEncoding));
      } else {
        ReadableByteChannel lineChannel = (new FileInputStream(fileName)).getChannel();
        lineReader = new BufferedReader(Channels.newReader(lineChannel , srcEncoding));
      }
      String line = null;
      Sequence seq = null;
      while ((line = lineReader.readLine()) != null) { // read and process lines
        lineNo ++;
        if (line != null) {
          if (line.startsWith("A")) { // valid A-number
            String[] parts = new String[8];
            String[] elems = line.split("\\t");
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
            aseqno  = parts[ipart++];;
            String callCode = parts[ipart++];
            final String className = "irvine.oeis.a" + aseqno.substring(1, 4) + '.' + aseqno;
            try {
              if (false) { // switch for callCodes

              } else if (callCode.startsWith("conti")) { // root and period
                superNextMethod = contiNextMethod;
                ContinuedFractionOfSqrtSequence hseq = (ContinuedFractionOfSqrtSequence) Class.forName(className).getDeclaredConstructor().newInstance();
                seq = hseq;
                ipart++; // skip offset
                hseq.fillPeriod();
                final int plen = hseq.getPeriodLength();
                parts[ipart++] = getPeriodicRecurrence(plen); // MATRIX
                
                buffer.setLength(0);
                buffer.append('[');
                buffer.append(hseq.next().divide2().toString()); // root
                for (int iterm = 0; iterm < plen; ++iterm) {
                  buffer.append(',');
                  buffer.append(hseq.next().toString());
                }
                buffer.append(']');
                parts[ipart++] = buffer.toString(); // INIT
                parts[ipart++] = "0";
                parts[ipart++] = "0";

              } else if (callCode.startsWith("finit")) { // finite list followed null (later: by zeroes)
                superNextMethod = finitNextMethod;
                FiniteSequence hseq = (FiniteSequence) Class.forName(className).getDeclaredConstructor().newInstance();
                seq = hseq;
                ipart++; // skip offset
                parts[ipart++] = "[0]"; // MATRIX or later "[0,-1]"
                parts[ipart++] = getVectorString(hseq.getInitTerms()); // INIT
                parts[ipart++] = "0";
                parts[ipart++] = "0";

              } else if (callCode.startsWith("gener") 
                  ||     callCode.startsWith("coord")
                  ||     callCode.startsWith("coxet")
                  ) { // fraction of two polynomials
                superNextMethod = generNextMethod;
                GeneratingFunctionSequence hseq = (GeneratingFunctionSequence) Class.forName(className).getDeclaredConstructor().newInstance();
                seq = hseq;
                ipart++; // skip offset
                final Z[] num = hseq.getNum();
                final Z[] den = hseq.getDen();
                final int mlen = num.length;
                final int dlen = den.length;
                buffer.setLength(0);
                for (int iterm = dlen - 1; iterm >= 1; --iterm) {
                  buffer.append(',');
                  buffer.append(den[iterm].toString());
                }
                buffer.append(',');
                buffer.append(den[0].toString());
                parts[ipart++] = "[0" + buffer.toString() + "]"; // MATRIX

                buffer.setLength(0);
                for (int iterm = (dlen > mlen ? dlen : mlen); iterm >= 1; --iterm) {
                  buffer.append(',');
                  buffer.append(hseq.next().toString());
                }
                buffer.append(']');
                parts[ipart++] = "[" + buffer.substring(1); // INIT
                parts[ipart++] = "0";
                parts[ipart++] = String.valueOf(hseq.getGfType());

              } else if (callCode.startsWith("holon")) { // holonomic recurrence
                superNextMethod = holonNextMethod;
                HolonomicRecurrence hseq = (HolonomicRecurrence) Class.forName(className).getDeclaredConstructor().newInstance();
                seq = hseq;
                parts[ipart++] = String.valueOf(hseq.getOffset());
                parts[ipart++] = hseq.getPolyString();
                parts[ipart++] = hseq.getInitString();
                parts[ipart++] = String.valueOf(hseq.getDistance());
                parts[ipart++] = String.valueOf(hseq.getGfType());

              } else if (callCode.startsWith("linea")) { // reversed signature + initial terms
                superNextMethod = lineaNextMethod;
                LinearRecurrence hseq = (LinearRecurrence) Class.forName(className).getDeclaredConstructor().newInstance();
                seq = hseq;
                ipart++; // skip offset
                parts[ipart++] = getVectorString(hseq.getRecurrence())
                    .replaceAll("\\[", "[0,").replaceAll("\\]", ",-1]"); // +constant, -a(n) (align to HolonomicRecurrence)
                parts[ipart++] = getVectorString(hseq.getInitTerms());
                parts[ipart++] = "0";
                parts[ipart++] = "0"; // gfType = ordinary

              } else if (callCode.startsWith("paddi")) { // padding: padding terms repeated, overlaid by init terms
                superNextMethod = paddiNextMethod;
                PaddingSequence hseq = (PaddingSequence) Class.forName(className).getDeclaredConstructor().newInstance();
                seq = hseq;
                ipart++; // skip offset
                final Z[] terms = hseq.getInitTerms();
                final Z[] pads = hseq.getPaddingTerms();
                final int tlen = terms.length;
                final int plen = pads.length;
                final Z[] inits = new Z[tlen + plen];
                parts[ipart++] = getPeriodicRecurrence(plen); // MATRIX
                buffer.setLength(0);
                for (int iterm = 0; iterm < tlen + plen; ++iterm) {
                  buffer.append(',');
                  buffer.append(iterm < tlen ? terms[iterm].toString() : pads[iterm % plen].toString());
                }
                parts[ipart++] = "[" + buffer.substring(1) + "]"; // INIT
                parts[ipart++] = "0";
                parts[ipart++] = "0";

              } else if (callCode.startsWith("perio")) { // periodic
                superNextMethod = perioNextMethod;
                PeriodicSequence hseq = (PeriodicSequence) Class.forName(className).getDeclaredConstructor().newInstance();
                seq = hseq;
                ipart++; // skip offset
                final Z[] terms = hseq.getInitTerms();
                parts[ipart++] = getPeriodicRecurrence(terms.length); // MATRIX
                parts[ipart++] = getVectorString(terms); // INIT
                parts[ipart++] = "0";
                parts[ipart++] = "0";
              } else { // ignore
              } // end of switch for callCodes
              if (seq == null) { 
                // ignore
              } else if (parts[3].length() < 8192 && parts[4].length() < 4096) {
                final Method thisNextMethod = seq.getClass().getMethod("next");
                if (thisNextMethod.equals(superNextMethod)) {
                  for (ipart = 0; ipart < parts.length; ++ipart) { // print a tab-separated record
                    if (ipart > 0) {
                      System.out.print("\t");
                    }
                    System.out.print(parts[ipart]);
                  } // for ipart
                  System.out.println();
                } else {
                  System.err.println("# " + aseqno + "\t" + callCode + "\tdoesn't use super.next()");
                }
              } else {
                System.err.println("# " + aseqno + "\t" + callCode + "\trecord length > 8192 + 4096");
              }
            } catch (Exception exc) {
              System.err.println("# cannot construct " + className + ", exception: " + exc.getMessage());
              exc.printStackTrace();
            }
          } else { // commented out, empty ...
            // ignore lines without A-numbers
          }
        } // line != null
      } // while ! eof
      lineReader.close();
    } catch (Throwable exc) {
      System.err.println( "FATAL - cannot read \"" + fileName + "\" - " + exc.getMessage());
    } // try
  } // processBatch

  /** Processes the commandline arguments
   *  @param args commandline arguments:
   *  <ul>
   *  <li>-d level debugging level: 0=none, 1=some, 2=more (default: 0)</li>
   *  <li>input filename or "-" for STDIN</li>
   *  </ul>
   */
  public void processArguments(String[] args) {
    int iarg = 0;
    if (args.length == 0) {
      System.out.print("Usage: RecurrenceReflector [-d level] {- | filename}\n"
          + "    -d level      debugging level: 0=none, 1=some, 2=more (default: 0)\n"
          );
      return;
    }
    String fileName = "-"; // default: read from STDIN
    while (iarg < args.length && args[iarg].startsWith("-")) {
      String arg = args[iarg ++];
      if (false) {

      } else if (arg.startsWith("-d")) {
        try {
          debug = Integer.parseInt(args[iarg ++]);
        } catch (Throwable exc) {
          // silently assume default
        }
      }

    } // while iarg
    if (iarg < args.length) {
      fileName = args[iarg ++];
    }
    processBatch(fileName);
  } // processArguments

  /** Main method
   *  @param args command line arguments: filename or "-"
   */
  public static void main(String[] args) {
    (new RecurrenceReflector()).processArguments(args);
  } // main

} // RecurrenceReflector
