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
import  java.util.ArrayList;

/** Reads a subset of OEIS 'stripped', calls joeis sequences and compares the results
 *  @author Dr. Georg Fischer
 */
public class BatchTest {
  public final static String CVSID = "@(#) $Id: BatchTest.java 744 2019-04-05 06:29:20Z gfis $";

  /** Encoding of the input file */
  private String srcEncoding = "UTF-8";
  
  /** Level of output verbosity (0-3, default 0) */
  private int verbosity = 0;

  /** Whether to read terms from corresponding b-file */
  private boolean readFromBFile = false;

  /** Directory where b-files can be found */
  private String bFileDirectory = "./bfile";

  /** Indicator for b-file read error */
  private int READ_ERROR = -29061947; // more than any b-file index
  /** No-args Constructor
   */
  public BatchTest() {
  } // no-args Constructor

  /** Tests a sequence against the terms in a b-file.
   *  @param aseqno A-number of the sequence
   *  @param seq Sequence instance to be tested
   *  @return &gt;= 1: passed (number of terms), &lt;= 0 failed (-index of failure), -1 = could not read b-file
   */
  private int testAgainstBFile(String aseqno, Sequence seq) {
    int result = 1; // assume passed
    int count = 0; // number of evaluated tests
    try {
      String fileName = bFileDirectory + "/b" + aseqno.substring(1) + ".txt";
      ReadableByteChannel lineChannel = (new FileInputStream(fileName)).getChannel();
      BufferedReader lineReader = new BufferedReader(Channels.newReader(lineChannel , srcEncoding));
      String line = null;
      while (result == 1 && (line = lineReader.readLine()) != null) { // read and process lines
        if (line != null) {
          int hashPos = line.indexOf('#');
          if (hashPos >= 0) { // hash found
            line = line.substring(0, hashPos); // remove comment
          }
          line.replaceAll("\\s+", " "); // beware of \t, \r
          line = line.trim(); // remove any surrounding space
          if (line.length() > 0) { // line not empty
            int spacePos = line.indexOf(' ');
            String expected = line.substring(spacePos + 1);
            result = testNext(aseqno, seq, count, expected);
            count ++;
          } // line not empty
        } // line != null
      } // while ! eof
      lineReader.close();
    } catch (Exception exc) {
      System.err.println(aseqno + "\tread b-file error: " + exc.getMessage());
      // exc.printStackTrace();
      result = READ_ERROR; // read failure
    } // try
    if (result == 1) {
      result = count;
    } else if (result == 0) {
      result = - count;
    }
    return result;
  } // testAgainstBFile

  /** Test the next term computed by the sequence
   *  @param aseqno A-number of <em>seq</em>
   *  @param seq Sequence to be tested
   *  @param count index of term to be tested
   *  @param expected exprected term for a(n)
   *  @return 1 = passed, 0 = failed
   */     
  private int testNext(String aseqno, Sequence seq, int count, String expected) {
    int result = 1;
    String computed = seq.next().toString();
    if (! computed.equals(expected)) {
      result = 0;
      System.out.println(aseqno + "\tFAILED, expected @" + count + " = " + expected 
          + "\tcomputed: " + computed);
    } 
    return result;
  } // testNext

  /** Test one sequences with an array of terms
   *  either from file 'stripped', or from the b-file.
   *  @param aseqno A-number of the sequence
   *  @param terms array of integer values (as Strings)
   */
  private void testSequence(String aseqno, String[] terms) {
    Sequence seq   = null; // invoke this sequence
    String message = "\tconstruction failed: ";
    try {
      seq = (Sequence) Class.forName("irvine.oeis.a" + aseqno.substring(1, 4) + '.' + aseqno).newInstance();
    } catch (Exception exc) {
      // remains null for any errors
      message += exc.getMessage();
    }
    if (seq != null) {
      int termNo = terms.length; // Math.min(terms.length, maxTerms());
      int result = 1; // assume passed
      if (readFromBFile) { // try the b-file first
        result = testAgainstBFile(aseqno, seq);
      }
      if ((result == READ_ERROR && termNo > 0) || ! readFromBFile) { 
        // test against terms from 'stripped', maybe as fallback
        result = 1;
        int count = 0; // number of evaluated tests
        while (result == 1 && count < termNo) {  
          result = testNext(aseqno, seq, count, terms[count]);
          count ++;
        } // while n 
        if (result == 1) {
          result = count;
        } else {
          result = - count;
        }
      } // terms from 'stripped'
      if (result >= 1 && verbosity >= 1) {
        System.out.println(aseqno + "\tpassed: " + result + " terms");
      } 
      try {
        if (seq instanceof Closeable) {
          ((Closeable) seq).close();
        }
      } catch (Exception exc) {
        System.err.println(aseqno + "\tcould not close seq: " + exc.getMessage());
        exc.printStackTrace();
      }
    } else {
      System.out.println(aseqno + message);
    }
  } // testSequence
  
  /** Processes lines of the form 
   *  <pre>A040954 ,31,2,2,62,2,2,62,</pre>
   *  and evaluates the corresponding sequence with the terms.
   *  @param fileName name of input file or "-" for STDIN
   */
  public void processBatch(String fileName) {
    BufferedReader lineReader = null;
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
          if (readFromBFile) {
            if (parts.length > 0) {
              testSequence(aseqno, parts[1].replaceAll("\\,\\Z", "").split("\\,")); // for fallback
            } else {
              testSequence(aseqno, new String[] {});
            }
          } else { // terms from 'stripped'
            testSequence(aseqno, parts[1].replaceAll("\\,\\Z", "").split("\\,"));
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
   *  <li>-b b-file-directory</li>
   *  <li>-v, -vv, -vvv: level of verbosity</li>
   *  <li>input filename or "-" for STDIN</li>
   *  </ul>
   */
  public void processArguments(String[] args) {
    int iarg = 0;
    if (args.length == 0) {
      System.out.println("Usage: BatchTest [-v[v]] [-b bfile-dir] {- | filename}");
      return;
    }
    String fileName = "-"; // default: read from STDIN
    while (iarg < args.length && args[iarg].startsWith("-")) {
      String arg = args[iarg ++];
      if (false) {
      } else if (arg.startsWith("-b")) {
        readFromBFile  = true;
        bFileDirectory = args[iarg ++];
      } else if (arg.startsWith("-v")) {
        verbosity = arg.length() - 1;
      } else {
        System.err.println("BatchTest: unknown option: " + args[iarg]);
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
