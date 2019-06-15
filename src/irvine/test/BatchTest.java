/*  Reads a subset of OEIS 'stripped', calls joeis sequences and compares the results
 *  @(#) $Id: BatchTest.java 744 2019-04-05 06:29:20Z gfis $
 *  2019-06-15: timeDiff behind "pass"
 *  2019-06-06: write "aseqno start" V1.12
 *  2019-06-04: increase version to V1.11; abbreviated terms
 *  2019-05-24: FAIL if failCount > 0
 *  2019-05-11: FAIL shows several terms
 *  2019-04-14: programmatic getShortTrace
 *  2019-04-13: with timeGuard
 *  2019-04-10: Sequence.next() may return null
 *  2019-04-09: read from b-file
 *  2019-04-05, Georg Fischer: copied from org.teherba.ramath.util.ExpressionReader
 */
package irvine.test;
import  irvine.math.z.Z;
import  irvine.oeis.Sequence;

import  java.io.BufferedReader;
import  java.io.Closeable;
import  java.io.FileInputStream;
import  java.io.InputStreamReader;
import  java.nio.channels.Channels;
import  java.nio.channels.ReadableByteChannel;
import  java.util.ArrayList;

/** Reads a subset of OEIS 'stripped', calls jOEIS sequence classes 
 *  and compares the results
 *  @author Dr. Georg Fischer
 */
public class BatchTest {
  public final static String CVSID = "@(#) $Id: BatchTest.java 744 2019-04-05 06:29:20Z gfis $";

  /** This program's version */
  private static String VERSION = "BatchTest V1.13";

  /** A-number of sequence currently tested */
  private String  aseqno;

  /** Directory where b-files can be found */
  private String  bFileDirectory;

  /** Number of terms already computed by the sequence */
  private int     count;

  /** String of terms which were computed differently */
  private String  diffComputed;

  /** String of terms which were expected differently */
  private String  diffExpected;

  /** Maximum length of term difference Strings */
  private static final int MAX_LENGTH = 32;

  /** Number of successive failures */
  private int     failCount;

  /** Allowed number of successive failures */
  private int     maxFailCount;

  /** Debugging level: 0 = none, 1 = some, 2 = more */
  private int     debug;

  /** How many milliseconds should a single sequence be allowed to run */
  private long    millisToRun;

  /** Indicator for b-file read error */
  private static final int READ_ERROR = -29061947; // more than any b-file index

  /** Whether to read terms from corresponding b-file */
  private boolean readFromBFile;

  /** Flag which is reset when the timer has expired */
  public boolean  sequenceMayRun;

  /** Encoding of the input file */
  private String  srcEncoding;

  /** Level of output verbosity (0-3, default 0) */
  private int     verbosity;

  /** the sequence started at this Linux time */
  private long    startTime; 
  /** difference between current time and {@link #startTime} */
  private long    timeDiff; 

  /** No-args Constructor
   */
  public BatchTest() {
    // set default for variables and arguments
    debug          = 0;
    maxFailCount   = 4;
    millisToRun    = 4000L;
    sequenceMayRun = true;
    bFileDirectory = "./bfile";
    readFromBFile  = false;
    verbosity      = 1;
    srcEncoding    = "UTF-8";
  } // no-args Constructor

  /** Returns the abbreviated stack trace information.
   *  @param exc Throwable which caused the exception
   *  @return a list of source points, up to this.next()
   */
  public String getShortTrace(Throwable exc) {
    String result = "";
    StackTraceElement[] callPoints = exc.getStackTrace();
    int icall = 0;
    while (icall <      callPoints.length) {
      String element =  callPoints[icall].toString();
      result += ", " +  element;
      if (element.contains("BatchTest.testNext")) {
        icall =         callPoints.length; // break loop
      }
      icall ++;
    } // while icall
    return result;
  } // getShortTrace

  /*  Get a term, possibly abbreviated 
   *  @param term original term
   *  @return term with middle digits replace by "..." if it was longer than MAX_LENGTH
   */
  private String abbrev(String term) {
  	  String result = term;
  	  int tlen = term.length();
  	  if (tlen > MAX_LENGTH) {
  	  	  result = term.substring(0, MAX_LENGTH/2) + "..." + term.substring(tlen - MAX_LENGTH/2);
  	  }
  	  return result;
  } // abbrev
  
  /** Test the next term computed by the sequence
   *  @param  seq Sequence to be tested
   *  @param  expected expected term for a(n)
   *  @return 0 = passed, 1 = failed
   */
  private int testNext(Sequence seq, String expected) {
    int failure = 0; // assume pass
    try {
      Z term = seq.next();
      count ++; // one more is computed
      if (term == null) { // e.g. beyond end of FiniteSequence
        failure = 1; // FAIL
        System.out.println    (aseqno + "\t" + count + "\tFAIL\t"     
            + expected + "\tcomputed:\tnull");
      } else {
        String computed = term.toString();
        if (! computed.equals(expected) || failCount > 0) {
          int clen = computed.length();
          int elen = expected.length();
          diffComputed += "," + abbrev(computed);
          diffExpected += "," + abbrev(expected);
          failCount ++; // maybe FAIL
          if (failCount >= maxFailCount) {
            failure = 1;
          }
        } else if (! sequenceMayRun) {
          failure = 1; // FAIL
          System.out.println  (aseqno + "\t" + count + "\tFATAL\t"    
              + timeDiff + " ms timeout expired");
        }
      }
    } catch (Exception exc) {
      failure = 1; // FAIL
      System.out.println      (aseqno + "\t" + count + "\tFATAL\tException\t"
          + exc.getMessage() + ", Stack: " + getShortTrace(exc));
    }
    return failure;
  } // testNext

  /** Tests a sequence against the terms in a b-file.
   *  @param seq Sequence instance to be tested
   *  @return &gt;= 1: passed (number of terms), &lt;= 0 failed (-index of failure), -1 = could not read b-file
   */
  private int testAgainstBFile(Sequence seq) {
    int failure = 0; // assume pass
    try {
      String fileName = bFileDirectory + "/b" + aseqno.substring(1) + ".txt";
      ReadableByteChannel lineChannel = (new FileInputStream(fileName)).getChannel();
      BufferedReader lineReader = new BufferedReader(Channels.newReader(lineChannel , srcEncoding));
      String line = null;
      while (sequenceMayRun && failure == 0 && (line = lineReader.readLine()) != null) { // read and process lines
        if (line != null) {
          int hashPos = line.indexOf('#');
          if (hashPos >= 0) { // hash found
            line = line.substring(0, hashPos); // remove comment
          }
          line = line.replaceAll("\\s+", " "); // beware of \t, \r whitespace
          line = line.trim(); // remove any surrounding space
          if (line.length() > 0) { // line not empty
            int spacePos = line.indexOf(' ');
            String expected = line.substring(spacePos + 1);
            failure = testNext(seq, expected);
            // count is incremented in testNext
          } // line not empty
        } // line != null
        timeDiff = System.currentTimeMillis() - startTime;
        if (timeDiff > millisToRun) {
          sequenceMayRun = false;
        }
      } // while ! eof
      lineReader.close();
    } catch (Exception exc) {
      System.out.println      (aseqno + "\t" + count + "\tFATAL - read b-file error: "
          + exc.getMessage() + ", Stack: " + getShortTrace(exc));
      failure = READ_ERROR; // read failure
    } // try
    return failure;
  } // testAgainstBFile

  /** Test one sequences with an array of terms
   *  either from file 'stripped', or from the b-file.
   *  @param terms array of integer values (as Strings)
   */
  private void testSequence(String[] terms) {
    Sequence seq   = null; // invoke this sequence
    String message = "\t0\tFATAL: construction failed: ";
    try {
      seq = (Sequence) Class.forName("irvine.oeis.a" + aseqno.substring(1, 4) 
          + '.' + aseqno)
          // .getConstructor().newInstance();
          .newInstance();
    } catch (Exception exc) {
      // seq remains null for any errors
      message += exc.getMessage() + getShortTrace(exc);
    }

    if (seq != null) {
      failCount = 0;
      diffComputed = "";
      diffExpected = "";
      // cf. <https://stackoverflow.com/questions/2550536/java-loop-for-a-certain-duration>
      // and <http://tutorials.jenkov.com/java-concurrency/creating-and-starting-threads.html#stop-a-thread>
      startTime = System.currentTimeMillis();
      sequenceMayRun = true;

      int termNo = terms.length; // Math.min(terms.length, maxTerms());
      if (debug >= 2) {
        System.err.println("BatchTest starts " + aseqno + " with " + termNo + " terms");
      }
      int failure = 0; // assume passed
      count = 0;
      if (readFromBFile) { // try the b-file first
        failure = testAgainstBFile(seq);
      }
      if ((failure == READ_ERROR && termNo > 0) || ! readFromBFile) {
        // test against terms from 'stripped', maybe as fallback
        count = 0; // number of evaluated tests
        failure = 0; // assume pass
        while (sequenceMayRun && failure == 0 && count < termNo) {
          failure = testNext(seq, terms[count]);
          // count is incremented in testNext
          timeDiff = System.currentTimeMillis() - startTime;
          if (timeDiff > millisToRun) {
            sequenceMayRun = false;
          }
        } // while n
      } // terms from 'stripped'
      if (! sequenceMayRun) {
        System.out.println    (aseqno + "\t" + count + "\tFAIL - timeout "
            + timeDiff + " > " + millisToRun + " ms");
      } else if (failCount == 0) {
      	if (verbosity >= 1) {
        	System.out.println    (aseqno + "\t" + count + "\tpass\t" + timeDiff + " ms");
        }
      } else if (failCount > 0) {
            System.out.println  (aseqno + "\t" + count
                + "\tFAIL\t"      + diffExpected
                + "\tcomputed:\t" + diffComputed + "");
      }
      try {
        if (seq instanceof Closeable) {
          ((Closeable) seq).close();
        }
      } catch (Exception exc) {
        System.out.println      (aseqno + "\t" + count + "\tFATAL - could not close sequence, "
          + exc.getMessage() + ", Stack: " + getShortTrace(exc));
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
          if (debug >= 2) {
            System.err.println("BatchTest read \"" + line + "\"");
          }
          if (line.startsWith("A")) { // valid A-number
            String[] parts = line.split("\\s\\,?");
            aseqno  = parts[0];
        	  System.out.println(aseqno + "\tstart");
            if (readFromBFile) {
              if (parts.length > 0) {
                testSequence(parts[1].replaceAll("\\,\\Z", "").split("\\,")); // for fallback
              } else {
                testSequence(new String[] {});
              }
            } else { // terms from 'stripped'
                testSequence(parts[1].replaceAll("\\,\\Z", "").split("\\,"));
            }
          } else { // commented out, empty ...
            System.out.println("# ignored: " + line);
          }
        } // line != null
      } // while ! eof
      lineReader.close();
    } catch (Exception exc) {
        System.out.println      (aseqno + "\t" + count + "\tFATAL - input read error, "
          + exc.getMessage() + ", Stack: " + getShortTrace(exc));
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
        bFileDirectory = args[iarg ++];
        readFromBFile  = true;
      } else if (arg.startsWith("-d")) {
        try {
          debug = Integer.parseInt(args[iarg ++]);
        } catch (Exception exc) {
          // silently assume default
        }
      } else if (arg.startsWith("-t")) {
        try {
          int tsecs = Integer.parseInt(args[iarg ++]);
          if (tsecs >= 0) { // positive: seconds
            millisToRun = tsecs * 1000L;
          } else { // negative: milliseconds
            millisToRun = - tsecs;
          }
        } catch (Exception exc) {
          // silently assume the default
        }
      } else if (arg.startsWith("-v")) {
        verbosity = arg.length() - 1;
      } else {
        System.err.println("BatchTest: unknown option: " + args[iarg]);
      }
    } // while iarg
    if (iarg < args.length) {
      fileName = args[iarg ++];
    }
    if (debug > 0) {
      System.err.println("BatchTest reads from \"" + fileName + "\"");
    }
    processBatch(fileName);
  } // processArguments

  /** Reads a subset of OEIS 'stripped', calls joeis sequences and compares the results
   *  @param args command line arguments: filename or "-"
   */
  public static void main(String[] args) {
    System.err.println(VERSION);
    (new BatchTest()).processArguments(args);
  } // main

} // BatchTest
