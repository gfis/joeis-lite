/*  Reads a subset of OEIS 'stripped', calls joeis sequences and compares the results
 *  @(#) $Id: BatchTest.java 744 2019-04-05 06:29:20Z gfis $
 *  2019-04-05, Georg Fischer: copied from org.teherba.ramath.util.ExpressionReader
 */
package irvine.test;
import  irvine.oeis.Sequence;
import  java.io.BufferedReader;
import  java.io.Closeable;
import  java.io.FileInputStream;
import  java.io.InputStreamReader;
import  java.nio.channels.Channels;
import  java.nio.channels.ReadableByteChannel;

/** Reads a subset of OEIS 'stripped', calls joeis sequences and compares the results
 *  @author Dr. Georg Fischer
 */
public class BatchTest {
  public final static String CVSID = "@(#) $Id: BatchTest.java 744 2019-04-05 06:29:20Z gfis $";

  /** Encoding of the input file */
  private String srcEncoding;
  
  /** Reader for the input file */
  private BufferedReader lineReader;

  /** Level of output verbosity (0-3, default 0) */
  private int verbosity = 0;

  /** No-args Constructor
   */
  public BatchTest() {
    this("UTF-8");
  } // no-args Constructor

  /** Constructor with encoding
   *  @param srcEncoding encoding of the input file
   */
  public BatchTest(String srcEncoding) {
    this.srcEncoding = srcEncoding;
    lineReader = null;
  } // Constructor(String, boolean)

  /** Processes lines of the form 
   *  <pre>A040954 ,31,2,2,62,2,2,62,</pre>
   *  and evaluates the corresponding sequence with the terms.
   *  @param fileName name of input file or "-" for STDIN
   */
  public void processBatch(String fileName) {
    try {
      if (fileName == null || fileName.length() <= 0 || fileName.equals("-")) {
        lineReader = new BufferedReader(new InputStreamReader(System.in, srcEncoding));
      } else {
        ReadableByteChannel lineChannel = (new FileInputStream(fileName)).getChannel();
        lineReader = new BufferedReader(Channels.newReader(lineChannel , srcEncoding));
      }
      String line = null;
      while ((line = lineReader.readLine()) != null) { // read and process lines
        if (line != null) {
          String[] parts = line.split("\\s\\,?");
          String aseqno  = parts[0];
          String[] terms = parts[1].replaceAll("\\,\\Z", "").split("\\,");
          Sequence seq   = null;
          try {
            seq = (Sequence) Class.forName("irvine.oeis.a" + aseqno.substring(1, 4) + '.' + aseqno).newInstance();
          } catch (Exception exc) {
            // remains null for any errors
          }
          if (seq != null) {
            int termNo     = terms.length; // Math.min(terms.length, maxTerms());
            boolean okay   = true;
            int n = 0;
            while (okay && n < termNo) {
              String result = seq.next().toString();
              if (! result.equals(terms[n])) {
                okay = false;
                System.out.println(aseqno + "\tFAILED, expected a(" + n + ") = " + terms[n] + "\tcomputed: " + result);
              } 
              n ++;
            } // while n 
            if (okay && verbosity >= 1) {
              System.out.println(aseqno + "\tpassed");
            } 
            if (seq instanceof Closeable) {
              ((Closeable) seq).close();
            }
          } else {
          	System.out.println(aseqno + " not found");
          }
        } // line != null
      } // while ! eof
      lineReader.close();
    } catch (Exception exc) {
      System.err.println("Failed: " + exc.getMessage());
      exc.printStackTrace();
    } // try
  } // processBatch

  /** Processes the commandline arguments 
   *  @param args commandline arguments: 
   *  <ul>
   *  <li>-v, -vv, -vvv: level of verbosity</li>
   *  <li>input filename or "-" for STDIN</li>
   *  </ul>
   */
  public void processArguments(String[] args) {
    int iarg = 0;
    if (args.length == 0) {
      System.out.println("Usage: BatchTest [-v[v]] {- | filename}");
			return;
    }
    String fileName = "-"; // default: read from STDIN
    while (iarg < args.length && args[iarg].startsWith("-")) {
      String arg = args[iarg ++];
      if (false) {
      } else if (arg.startsWith("-v")) {
        verbosity = arg.length() - 1;
      } else {
        System.err.println("BatchTest: unknown option");
      }
    } // while iarg
    if (iarg < args.length) {
      fileName = args[iarg ++];
    }
    processBatch(fileName); 
  } // processArguments

  /** Reads a subset of OEIS 'stripped', calls joeis sequences and compares the results
   *  @param args command line arguments: filename or "-"
   */
  public static void main(String[] args) {
    (new BatchTest()).processArguments(args);
  } // main

} // BatchTest
