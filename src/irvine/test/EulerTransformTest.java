/* Test class, run a EulerTransform of a Finite or PeriodicSequence
 * @(#) $Id$
 * 2020-08-18: EulerInvTransform
 * 2020-08-17: -f, CC=eulerx
 * 2020-08-14, Georg Fischer: copied from HolonomicRecurrenceTest
 */
package irvine.test;

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.EulerInvTransform;
import irvine.oeis.EulerTransform;
import irvine.oeis.FiniteSequence;
import irvine.oeis.PeriodicSequence;
import irvine.oeis.Sequence;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.Serializable;
import java.math.BigInteger;
import java.nio.channels.Channels;
import java.nio.channels.ReadableByteChannel;

/**
 * @author Georg Fischer
 */
public class EulerTransformTest {
  protected static int sDebug = 0;

  /** Fields of the input line */
  private String[] parms;

  /** A-number of the OEIS sequence */
  private String aseqno;

  /** Code for a specific generation process in joeis-lite */
  private String callCode;

  /** Number of terms to be generated */
  private static int numTerms;

  /** Offset of the sequence, as String */
  private int mOffset1;

  /** List of vectors for the coefficient polynomials */
  private String mPeriodString;

  /** Vectors for the initial terms */
  private String mPrefixString;

  /** Current index for {@link #parms} */
  private int iparm;

  /** Type of the underlying sequence: 0 = arbitrary, 1 = finite, 2 = periodic */
  private int mSeqType;

  /** Instance to be tested. */
  private EulerTransform mET;

  /**
   * Empty constructor.
   */
  protected EulerTransformTest() {
  }

  /**
   * Evaluate a {@link EulerTransform} or a {@link EulerInvTransform} and get a list
   * of the resulting data terms.
   * @param seq sequence to be evaluated
   * @param numTerms how many terms should be returned
   * @return a list of terms of the form "0,1,1,2,3,5,8".
   */
  private static String getDataList(Sequence seq, int numTerms) {
    StringBuffer result = new StringBuffer(256);
    int n = 0;
    boolean busy = true;
    while (n < numTerms && busy) {
      Z term = seq.next();
      if (term != null) {
        result.append(',');
        result.append(term.toString());
      } else {
        result.append(",null");
        busy = false; // break loop
      }
      n ++;
    } // while n
    return result.substring(1); // without leading comma
  } // getDataList

  /**
   * Compute the terms to be prefixed to the Euler transformed result sequence
   * @param expectedList term list from the OEIS, a lot longer than <code>numTerms</code>
   * @param et {@link EulerTransform} instance to be tested
   * @return a comma separated list of terms to be prefixed, usually "1"
   */
  public String computePrefix(String expectedList, EulerTransform et) {
    String computedList = "";
    String prefixList = "";
    for (int iterm = 0; iterm < numTerms; ++ iterm) {
      if (iterm > 0) {
        computedList += ",";
      }
      Z nextTerm = et.next();
      if (nextTerm == null) { // from FiniteSequence
        nextTerm = Z.ZERO;
      }
      computedList += nextTerm.toString();
    } // for iterm
    int start = expectedList.indexOf(computedList);
    if (start >= 0) { // found
      prefixList = expectedList.substring(0, start).replaceAll("\\,\\Z",""); // remove trailing comma
    } else {
      prefixList = "???";
      aseqno = "# " + aseqno; // turn it into a comment line
    }
    if (sDebug >= 1) {
      int limit = 32;
      parms[6] = "expt=" + (expectedList.length() < limit ? expectedList : expectedList.substring(0, limit));
      parms[7] = "comp=" + (computedList.length() < limit ? computedList : computedList.substring(0, limit));
      if (sDebug >= 2) {
        System.err.println("# ** aseqno: " + aseqno + ", expected=" + expectedList 
            + ", computed=" + computedList + " -> start=" + start + ", prefix=" + prefixList);
      }
    }
    return prefixList;
  } // computePrefix

  /**
   * Process one input line, and determine
   * whether it should be written to the output.
   * The following <code>callCode</code>s are processed:
   * <ul>
   * <li><code>eulerx</code> - set CC={eulerxf|eulerxp} and compute initial terms</li>
   * </ul>
   * The following parameters are already consumed: <em>aseqno, callCode, offset</em>.
   */
  private void processRecord() {
    boolean result = false;
    // records are: aseqno callCode offset1 seqType expectedTerms periodTerms ...
    String expectedList = ""; // initial terms for a(n)
    if (false) {
    // iparm == 3 here
    //----------------
    } else if (callCode.startsWith("eulerx")) { // set CC and compute prefixTerms
      mSeqType = 2; // assume periodic
      try {
        mSeqType = Integer.parseInt(parms[iparm ++]);
      } catch (Exception exc) {
        if (sDebug >= 1) {
          System.err.println("# ** aseqno=" + aseqno + ", iparm[" + iparm + "] = " + parms[iparm - 1]);
        }
      }
      expectedList  = parms[iparm ++].replaceAll("[\\{\\(]", "[").replaceAll("[\\}\\)]", "]");
      final int lastPos = expectedList.lastIndexOf(',');
      expectedList  = expectedList.substring(0, lastPos > 0 ? lastPos : 0);
      mPeriodString = parms[iparm ++].replaceAll("[\\{\\(]", "[").replaceAll("[\\}\\)]", "]");
      EulerTransform et = new EulerTransform(mSeqType, "[" + mPeriodString + "]", "");
      if (et != null) {
        iparm = 1;
        parms[iparm ++] = "eulerxfm";
        iparm ++; // skip offset
        iparm ++; // skip seqType
        parms[iparm] = computePrefix(expectedList, et);
        iparm ++;
        
        parms[iparm ++] = mPeriodString;
      /*
        switch (mSeqType) {
          default:
          case 1:
            parms[iparm ++] = "new FiniteSequence(" + mPeriodString + ")";
            break;
          case 2:
            parms[iparm ++] = "new PeriodicSequence(" + mPeriodString + ")";
            break;
        } // switch mSeqType
      */
        reproduce();
      } else {
        System.err.println("# " + aseqno + " ET construction failed, mSeqType=" + mSeqType+ ", mPeriodString=" + mPeriodString);
      }
    //----------------
    } else if (callCode.startsWith("euleri")) { // set CC and compute prefixTerms
      String keyword = parms[iparm ++];
      String prefix  = parms[iparm ++];
      mPeriodString  = parms[iparm ++].replaceAll("[\\{\\(]", "[").replaceAll("[\\}\\)]", "]");
      String[] terms = mPeriodString.split("\\,");
      int termNo = terms.length;
      EulerInvTransform eit = null;
      try {
         eit = new EulerInvTransform(1, "[" + mPeriodString + "]", "");
      } catch (Exception exc) {
        if (sDebug >= 1) {
          System.err.println("# ** aseqno: " + aseqno + ", mSeqType=" + mSeqType+ ", mPeriodString=" + mPeriodString);
        }
      }
      if (eit != null) {
        iparm = 1;
        parms[iparm ++] = "eulerixf";
        iparm ++; // skip offset
        parms[iparm ++] = "nonn"; // overwrite keyword
        iparm ++; // skip prefix
        parms[iparm   ] = getDataList(eit, termNo);
        parms[iparm + 1] = "term";
        if (parms[iparm].length() < numTerms) { // some heuristic
          reproduce();
        }
      } else {
        System.err.println("# " + aseqno + " ET construction failed, mSeqType=" + mSeqType+ ", mPeriodString=" + mPeriodString);
      }
    //----------------
    } else {
      reproduce();
      System.out.println("# " + aseqno + "\t" + "unknown callcode \"" + callCode + "\"");
    } // switch callCode
  } // processRecord

  /**
   * Reproduces the record with the (maybe modified) parameters.
   */
  protected void reproduce() {
    reproduce(parms.length);
  } // reproduce

  /**
   * Reproduces part of the the record with the (maybe modified) parameters.
   * @param num print only so many parameters.
   */
  protected void reproduce(int num) {
    int j = 0;
    while (j < num && j < parms.length) {
      System.out.print(j == 0 ? "" : "\t");
      System.out.print(parms[j]);
      j ++;
    } // for j
    System.out.println();
  } // reproduce(int)

  /**
   * Filters a file and writes the modified output lines.
   * @param fileName name of the input file, or "-" for STDIN
   */
  private void processFile(String fileName) {
    BufferedReader lineReader; // Reader for the input file
    String srcEncoding = "UTF-8"; // Encoding of the input file
    String line = null; // current line from text file
    try {
      if (fileName == null || fileName.length() <= 0 || fileName.equals("-")) {
        lineReader = new BufferedReader(new InputStreamReader(System.in, srcEncoding));
      } else {
        ReadableByteChannel lineChannel = (new FileInputStream(fileName)).getChannel();
        lineReader = new BufferedReader(Channels.newReader(lineChannel , srcEncoding));
      }
      while ((line = lineReader.readLine()) != null) { // read and process lines
        if (! line.matches("\\s*#.*")) { // is not a comment
          parms = line.split("\\t");
          if (sDebug >= 3) {
            System.out.println(line); // repeat it unchanged
          }
          iparm = 0;
          aseqno   = parms[iparm ++];
          callCode = parms[iparm ++];
          try {
            mOffset1 = 0;
            mOffset1 = Integer.parseInt(parms[iparm ++]);
          } catch (Exception exc) {
          }
          processRecord();
        } // is not a comment
      } // while ! eof
      lineReader.close();
    } catch (Exception exc) {
      System.err.println(exc.getMessage());
      exc.printStackTrace();
    } // try
  } // processFile

  /**
   * Main method, runs the transform from the arguments and writes a terms list to STDOUT.
   * @param args command line arguments:
   * <ul>
   * <li>-m number of terms to be generated (default: 32)
   * <li>-p period list of terms
   * <li>-s number of initial terms to skip (default: 0)
   * </ul>
   */
  public static void main(String[] args) {
    sDebug = 0;
    int iarg = 0;
    boolean inverse = false;
    EulerTransformTest ett = new EulerTransformTest();
    ett.mPeriodString = "1,0,1";
    ett.mPrefixString = "";
    ett.numTerms = 16;
    ett.mOffset1 = 0;
    ett.mSeqType = 2; // periodic
    String fileName = null; // not specified
    while (iarg < args.length) { // consume all arguments
      String opt = args[iarg ++];
      try {
        if (false) {
        } else if (opt.equals    ("-d")     ) {
          sDebug = 1;
          sDebug           = Integer.parseInt(args[iarg ++]);
        } else if (opt.equals    ("-f")     ) {
          fileName          = args[iarg ++];
        } else if (opt.equals    ("-i")     ) {
          ett.mPrefixString   = args[iarg ++]
              .replaceAll("\\s",""); // remove whitespace
        } else if (opt.equals    ("-m")     ) {
          ett.numTerms      = Integer.parseInt(args[iarg ++]);
        } else if (opt.equals    ("-o")     ) {
          ett.mOffset1      = Integer.parseInt(args[iarg ++]);
        } else if (opt.equals    ("-p")     ) {
          ett.mPeriodString = args[iarg ++]
              .replaceAll("\\s",""); // remove whitespace
        } else if (opt.equals    ("-s")     ) {
          ett.mSeqType      = Integer.parseInt(args[iarg ++]);
        } else if (opt.equals    ("-v")     ) {
          inverse           = true;
        } else {
          System.err.println("??? invalid option: \"" + opt + "\"");
        }
      } catch (Exception exc) { // take default
      }
    } // while args
    if (fileName == null) {
      if (! inverse) {
        ett.mET = new EulerTransform(ett.mSeqType, ett.mPeriodString, ett.mPrefixString);
        for (int iterm = 0; iterm < ett.numTerms; ++ iterm) {
          if (iterm > 0) {
            System.out.print(",");
          }
          System.out.print(ett.mET.next());
        } // for iterm
      } else {
        EulerInvTransform eit = new EulerInvTransform(1, ett.mPeriodString, ett.mPrefixString);
        System.out.println(getDataList(eit, ett.numTerms));
      }
    } else {
      ett.processFile(fileName);
    }
    System.out.println();
  } // main

} // EulerTransformTest
