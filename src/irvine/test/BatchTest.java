/*  Reads a subset of OEIS 'stripped', calls joeis sequences and compares the results
 *  @(#) $Id: BatchTest.java 744 2019-04-05 06:29:20Z gfis $
 *  2019-04-10: Sequence.next() may return null
 *  2019-04-09: read freom b-file
 *  2019-04-05, Georg Fischer: copied from org.teherba.ramath.util.ExpressionReader
 */
package irvine.test;
import  irvine.oeis.Sequence;
import  irvine.math.z.Z;
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
  private String  srcEncoding;
  
  /** Level of output verbosity (0-3, default 0) */
  private int     verbosity;

  /** Whether to read terms from corresponding b-file */
  private boolean readFromBFile;

  /** Directory where b-files can be found */
  private String  bFileDirectory;

  /** Indicator for b-file read error */
  private int     READ_ERROR = -29061947; // more than any b-file index

  /** How many milliseconds should a single sequence be allowed to run */
  private long    millisToRun; 

  /** Flag which is reset when the timer has expired */
  public boolean sequenceMayRun;

  /** Thread for the limitation of time a sequence may run */
  public Thread timeGuard;
  
  /** Whether to use the timeGuard */
  private boolean useTimeGuard;
    
  /** the sequence may run upp to this Linux time */
  private long endTime = System.currentTimeMillis();
  
  /** No-args Constructor
   */
  public BatchTest() {
    // set default for variables and arguments
    millisToRun    = 4000L;
    sequenceMayRun = true;
    bFileDirectory = "./bfile";
    readFromBFile  = false;
    verbosity      = 1;
    srcEncoding    = "UTF-8";
    useTimeGuard   = false;
    if (useTimeGuard) {
	    timeGuard = new Thread(
        new Runnable() { // set the alarm clock
          public void run() {
            try {
              Thread.sleep(millisToRun);
              sequenceMayRun = false; // alarm -> do no longer compute sequence.next()
            } catch (InterruptedException exc) {
              // normal at end of sequence - do nothing
            } catch (Exception exc) { // other
              System.err.println("Exception in thread: " + exc.getMessage());
              exc.printStackTrace();
            }
            // this thread dies
          }
        } // Runnable
        );
    } // if useTimeGuard
  } // no-args Constructor

  /** Test the next term computed by the sequence
   *  @param aseqno A-number of <em>seq</em>
   *  @param seq Sequence to be tested
   *  @param count index of term to be tested
   *  @param expected exprected term for a(n)
   *  @return 1 = passed, 0 = failed
   */     
  private int testNext(String aseqno, Sequence seq, int count, String expected) {
    int result = 1;
    try {
      Z term = seq.next();
      if (term == null) { // e.g. beyond end of FiniteSequence
        result = 0;
        System.out.println    (aseqno + "\t" + count + "\tFAIL\t"     + expected + "\tcomputed:\tnull");
      } else {
        String computed = term.toString();
        if (! computed.equals(expected)) {
          result = 0;
          System.out.println  (aseqno + "\t" + count + "\tFAIL\t"     + expected + "\tcomputed:\t" + computed + "");
        } else if (! sequenceMayRun) {
          result = 0;
          System.out.println  (aseqno + "\t" + count + "\tFATAL\t"    + millisToRun + " ms timeout expired");
        }
      }
    } catch (Exception exc) {
      result = 0;
      System.out.println      (aseqno + "\t" + count + "\tFATAL\tException\t"     + exc.getMessage());
      exc.printStackTrace();
    } 
    return result;
  } // testNext

  /** Tests a sequence against the terms in a b-file.
   *  @param aseqno A-number of the sequence
   *  @param seq Sequence instance to be tested
   *  @return &gt;= 1: passed (number of terms), &lt;= 0 failed (-index of failure), -1 = could not read b-file
   */
  private int testAgainstBFile(String aseqno, Sequence seq) {
    int result = 1; // assume passed
    int count  = 0; // number of evaluated tests
    try {
      String fileName = bFileDirectory + "/b" + aseqno.substring(1) + ".txt";
      ReadableByteChannel lineChannel = (new FileInputStream(fileName)).getChannel();
      BufferedReader lineReader = new BufferedReader(Channels.newReader(lineChannel , srcEncoding));
      String line = null;
      while (sequenceMayRun && result == 1 && (line = lineReader.readLine()) != null) { // read and process lines
        if (line != null) {
          int hashPos = line.indexOf('#');
          if (hashPos >= 0) { // hash found
            line = line.substring(0, hashPos); // remove comment
          }
          line = line.replaceAll("\\s+", " "); // beware of \t, \r
          line = line.trim(); // remove any surrounding space
          if (line.length() > 0) { // line not empty
            int spacePos = line.indexOf(' ');
            String expected = line.substring(spacePos + 1);
            result = testNext(aseqno, seq, count, expected);
            count ++;
          } // line not empty
        } // line != null
        if (System.currentTimeMillis() > endTime) {
          sequenceMayRun = false;
        }
      } // while ! eof
      lineReader.close();
    } catch (Exception exc) {
      System.err.println      (aseqno + "\t" + count + "\tFATAL - read b-file error: " + exc.getMessage());
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

  /** Test one sequences with an array of terms
   *  either from file 'stripped', or from the b-file.
   *  @param aseqno A-number of the sequence
   *  @param terms array of integer values (as Strings)
   */
  private void testSequence(String aseqno, String[] terms) {
    Sequence seq   = null; // invoke this sequence
    String message = "\t0\tFATAL: construction failed: ";
    try {
      seq = (Sequence) Class.forName("irvine.oeis.a" + aseqno.substring(1, 4) + '.' + aseqno)
          // .getConstructor().newInstance();
          .newInstance();
    } catch (Exception exc) {
      // remains null for any errors
      message += exc.getMessage();
    }
    if (seq != null) {
      // cf. <https://stackoverflow.com/questions/2550536/java-loop-for-a-certain-duration>
      // and <http://tutorials.jenkov.com/java-concurrency/creating-and-starting-threads.html#stop-a-thread>
      endTime = System.currentTimeMillis() + millisToRun;
      sequenceMayRun = true;
      if (useTimeGuard) {
        timeGuard.start();
      }

      int termNo = terms.length; // Math.min(terms.length, maxTerms());
      int result = 1; // assume passed
      if (readFromBFile) { // try the b-file first
        result = testAgainstBFile(aseqno, seq);
      }
      int count = 0; // number of evaluated tests
      if ((result == READ_ERROR && termNo > 0) || ! readFromBFile) { 
        // test against terms from 'stripped', maybe as fallback
        result = 1;
        while (sequenceMayRun && result == 1 && count < termNo) {  
          result = testNext(aseqno, seq, count, terms[count]);
          count ++;
          if (System.currentTimeMillis() > endTime) {
            sequenceMayRun = false;
          }
        } // while n 
        if (result == 1) {
          result = count;
        } else {
          result = - count;
        }
      } // terms from 'stripped'
      if (result >= 1 && verbosity >= 1) {
        System.out.println    (aseqno + "\t" + result + "\tpass");
      }
      try {
        if (seq instanceof Closeable) {
          ((Closeable) seq).close();
        }
        if (sequenceMayRun) { // still guarding
          if (useTimeGuard) {
            timeGuard.interrupt();
          }
        }
      } catch (Exception exc) {
        System.err.println    (aseqno + "\t" + count + "\tFATAL: could not close seq: " + exc.getMessage());
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
          if (line.startsWith("A")) { // valid A-number
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
          } else { // commented out, empty ...
            System.out.println("# ignored: " + line);
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
      System.out.print("Usage: BatchTest [-v[v]] [-b bfile-dir] [-t timeout] {- | filename}\n"
          + "    -b directory  check against b-files in this directory (default: off)\n"
          + "    -v, -vv, -vvv verbosity level\n"
          + "    -t seconds    interrupt a sequence after this time (default: 4 s)\n"
          );
      return;
    }
    String fileName = "-"; // default: read from STDIN
    while (iarg < args.length && args[iarg].startsWith("-")) {
      String arg = args[iarg ++];
      if (false) {
      } else if (arg.startsWith("-b")) {
        readFromBFile  = true;
        bFileDirectory = args[iarg ++];
      } else if (arg.startsWith("-t")) {
        try {
          int tsecs = Integer.parseInt(args[iarg]);
          if (tsecs >= 0) { // psositive: seconds
            millisToRun = tsecs * 1000L;
          } else { // negative: milliseconds
            millisToRun = - tsecs;
          }
        } catch (Exception exc) {
          millisToRun = 4000L; // silently assume the default
        } 
        iarg ++;
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
