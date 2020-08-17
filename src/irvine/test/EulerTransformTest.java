/* Test class, run a EulerTransform of a Finite or PeriodicSequence
 * @(#) $Id$
 * 2020-08-17: -f, CC=eulerx
 * 2020-08-14, Georg Fischer: copied from HolonomicRecurrenceTest
 */
package irvine.test;

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.EulerTransform;
import irvine.oeis.FiniteSequence;
import irvine.oeis.PeriodicSequence;
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
      parms[6] = expectedList.length() < 16 ? expectedList : expectedList.substring(0, 16);
      parms[7] = computedList.length() < 16 ? computedList : computedList.substring(0, 16);
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
    // iparm == 3 here
    String expectedList = ""; // initial terms for a(n)
    mSeqType = 2; // assume periodic
    try {
      mSeqType = Integer.parseInt(parms[iparm ++]);
    } catch (Exception exc) {
      if (sDebug >= 1) {
        System.err.println("# ** aseqno=" + aseqno + ", iparm[" + iparm + "] = " + parms[iparm - 1]);
      }
    }
    expectedList  = parms[iparm ++].replaceAll("[\\{\\(]", "[").replaceAll("[\\}\\)]", "]");
    mPeriodString = parms[iparm ++].replaceAll("[\\{\\(]", "[").replaceAll("[\\}\\)]", "]");
    if (false) {
    } else if (callCode.startsWith("eulerx")) { // set CC and compute prefixTerms
      numTerms = 8;
      try {
        mET = new EulerTransform(mSeqType, "[" + mPeriodString + "]", "");
      } catch (Exception exc) {
        if (sDebug >= 1) {
          System.err.println("# ** aseqno: " + aseqno + ", mSeqType=" + mSeqType+ ", mPeriodString=" + mPeriodString);
        }
      }
      if (mET != null) {
        iparm = 1;
        parms[iparm ++] = "eulerxfm";
        iparm ++; // skip offset
        iparm ++; // skip seqType
        parms[iparm] = computePrefix(expectedList, mET);
        if (parms[iparm].length() == 0) {
            parms[iparm] = "new Z[0]";
        }
        iparm ++;
        switch (mSeqType) {
          default:
          case 1:
            parms[iparm ++] = "new FiniteSequence(" + mPeriodString + ")";
            break;
          case 2:
            parms[iparm ++] = "new PeriodicSequence(" + mPeriodString + ")";
            break;
        } // switch mSeqType
        reproduce();
      } else {
        System.err.println("# " + aseqno + " ET construction failed, mSeqType=" + mSeqType+ ", mPeriodString=" + mPeriodString);
      }

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
          if (sDebug >= 2) {
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
    EulerTransformTest ett = new EulerTransformTest();
    ett.mPeriodString = "1,0,1";
    ett.mPrefixString = "1";
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
        } else {
          System.err.println("??? invalid option: \"" + opt + "\"");
        }
      } catch (Exception exc) { // take default
      }
    } // while args
    if (fileName == null) {
      ett.mET = new EulerTransform(ett.mSeqType, ett.mPeriodString, ett.mPrefixString);
      for (int iterm = 0; iterm < ett.numTerms; ++ iterm) {
        if (iterm > 0) {
          System.out.print(",");
        }
        System.out.print(ett.mET.next());
      } // for iterm
    } else {
      ett.processFile(fileName);
    }
    System.out.println();
  } // main

} // EulerTransformTest
