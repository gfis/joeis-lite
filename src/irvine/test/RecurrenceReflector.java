/*  Reads a list of A-numbers and appends the parameters of the sequences 
 *  @(#) $Id: RecurrenceReflector.java 744 2019-04-05 06:29:20Z gfis $
 *  2021-01-23, Georg Fischer: copied from BatchTest
 */
package irvine.test;
import irvine.math.z.Z;
import irvine.oeis.GeneratingFunctionSequence;
import irvine.oeis.HolonomicRecurrence;
import irvine.oeis.LinearRecurrence;
import irvine.oeis.Sequence;

import java.io.BufferedReader;
import java.io.Closeable;
import java.io.File; // delete()
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.nio.channels.Channels;
import java.nio.channels.FileChannel; // seekable()
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

  /** Processes lines of the form
   *  <pre>A040954\tcallcode\t...</pre>
   *  and reflect the corresponding sequence
   *  @param fileName name of input file or "-" for STDIN
   */
  public void processBatch(final String fileName) {
    int lineNo = 0;
    try {
      FileChannel channel = (new FileInputStream (fileName)).getChannel();
      BufferedReader charReader = new BufferedReader(Channels.newReader(channel, srcEncoding));
      String line = null;
      while ((line = charReader.readLine()) != null) { // read and process lines
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
              } else if (callCode.startsWith("gener") 
                  ||     callCode.startsWith("coord")
                  ||     callCode.startsWith("coxet")
                  ) {
                GeneratingFunctionSequence seq = (GeneratingFunctionSequence) Class.forName(className).getDeclaredConstructor().newInstance();
                ipart++; // skip offset
                parts[ipart++] = getVectorString(seq.getDen());
                parts[ipart++] = getVectorString(seq.getNum());
                parts[ipart++] = "";
                parts[ipart++] = String.valueOf(seq.getGfType());
              } else if (callCode.startsWith("holon")) {
                HolonomicRecurrence seq = (HolonomicRecurrence) Class.forName(className).getDeclaredConstructor().newInstance();
                parts[ipart++] = String.valueOf(seq.getOffset());
                parts[ipart++] = seq.getPolyString();
                parts[ipart++] = seq.getInitString();
                parts[ipart++] = String.valueOf(seq.getDistance());
                parts[ipart++] = String.valueOf(seq.getGfType());
              } else if (callCode.startsWith("linea")) {
                LinearRecurrence seq = (LinearRecurrence) Class.forName(className).getDeclaredConstructor().newInstance();
                ipart++; // skip offset
                parts[ipart++] = getVectorString(seq.getRecurrence()).replaceAll("\\[","[0,"); // constant, align to Holon.Rec.
                parts[ipart++] = getVectorString(seq.getInitTerms());
                parts[ipart++] = "";
                parts[ipart++] = "0"; // gfType = ordinary
              } // end of switch for callCodes
              
              for (ipart = 0; ipart < parts.length; ++ipart) { // print a tab-separated record
                if (ipart > 0) {
                  System.out.print("\t");
                }
                System.out.print(parts[ipart]);
              } // for ipart
              System.out.println();
            } catch (Exception exc) {
              System.out.println("# cannot construct " + className + ", exception: " + exc.getMessage());
              exc.printStackTrace();
            }
          } else { // commented out, empty ...
            // ignore lines without A-numbers
          }
        } // line != null
      } // while ! eof
      charReader.close();
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
