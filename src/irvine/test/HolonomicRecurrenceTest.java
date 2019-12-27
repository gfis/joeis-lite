/* Test class HolonomicRecurrence, determine init terms, run backwards
 * @(#) $Id$
 * 2019-12-12: -p polylist -i initterms
 * 2019-12-08: Georg Fischer
 */
package irvine.test;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.Serializable;
import java.math.BigInteger;
import java.nio.channels.Channels;
import java.nio.channels.ReadableByteChannel;
import java.util.ArrayList;

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.HolonomicRecurrence;

/**
 * A holonomic sequence is defined by a recurrence equation
 * where the factors <code>P[i], i=0..k</code> of <code>a[n-i], i=0..k</code> are either constant
 * (like in <code>LinearRecurrence.java</code>), or are polynomials in <code>n</code>..
 * The equation is written in the form of an <code>annihilator</code>:
 * <pre>
 * P[0]*1 + P[1]*a[n-k+1] + P[2]*a[n-k+2] + ...+ P[k-1]*a[n-k+k-1] + P[k]*a[n] = 0
 * </pre>
 * <code>k-1</code> is the order of the recurrence,
 * and <code>p[i], i= 0..k</code> are the polynomials (or constants) in <code>n</code>.
 * <code>a[n]</code> is the next term to be computed.
 * The recurrence equation may have a term <code>P[0]</code> which is independent
 * of any sequence term.
 * This class runs {@link HolonomicRecurrence}
 * <ul>
 * <li>with parameter lists read from a file,</li>
 * <li>for the determination of the necessary initial terms,</li>
 * <li>backwards to get a new sequence.</li>
 * </ul>
 * @author Georg Fischer
 */
public class HolonomicRecurrenceTest {
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
  private int mOffset;

  /** Distance d > 0 if a(n+d) is the highest and next element to be computed (0 <= d <= k). */
  private int mNDist;

  /** List of vectors for the coefficient polynomials */
  private String mPolyString;

  /** Vectors for the initial terms */
  private String mInitString;

  /** Current index for {@link #parms} */
  private int iparm;

  /** Instance to be tested. */
  private HolonomicRecurrence mHolRec;

  /**
   * Empty constructor.
   */
  protected HolonomicRecurrenceTest() {
    mHolRec = new HolonomicRecurrence(0, "[0,1,1,-1]" /* Fibonacci */, "[0,1]", 0);
  }

//  /**
//   * Evaluate the recurrence and gets a list of terms.
//   * @param holRec instance to be reversed
//   * @return a call to RecurrenceTable.
//   */
//  private String getMathematica(HolonomicRecurrence holRec) {
//    StringBuffer result = new StringBuffer(256);
//    int ind = 0;
//    result.append("RecurrenceTable[{");
//    for (ind = 0; ind < mPolyString.size(); ind ++) { // polynomials
//      Z[] poly = mPolyString.get(ind);
//      for (int iexp = 0; iexp < poly.length; iexp ++) {
//        if (iexp > 0) {
//          result.append(',');
//        }
//      } // iexp
//      result.append(",a[");
//      result.append(ind);
//      result.append("]=");
//      result.append(mInitString[ind]);
//    } // for ind - polynomials
//
//    result.append("=0, ");
//    for (ind = 0; ind < mInitString.size(); ind ++) { // initial terms
//      result.append(",a[");
//      result.append(ind);
//      result.append("]=");
//      result.append(mInitString[ind]);
//    } // for ind - initial
//    result.append("},a,{n,");
//    result.append(mOffset);
//    result.append(",");
//    result.append(mNumTerms);
//    result.append("}]");
//    return result.toString();
//  } // getMathematica

  /**
   * Reverse a comma separated list of coefficients,
   * but do not change any sign.
   * @param coeffs source String, for example "1,-1,-2,0"
   * @return a new comma separated list in vector form, for example "[0,-2,-1,1]"
   */
  private static String reverse(String coeffs) {
    StringBuffer result = new StringBuffer(256);
    String[] rcoeffs = coeffs.replaceAll("[\\}\\]\\)\\{\\[\\(\\s]", "").split("\\,");
    for (int icoeff = rcoeffs.length - 1; icoeff >= 0; icoeff --) {
        result.append(',');
        result.append(rcoeffs[icoeff]);
    } // for icoeff
    return "[" + result.substring(1) + "]";
  } // reverse(String)

  /**
   * Reverse <code>this</code> recurrence, that is
   * reverse the order of the polynomials and of the initial terms,
   * but do not change any sign.
   * @param holRec instance to be reversed
   * @param initSize number of initial terms to be kept (from the end)
   * @return a new HolonomicRecurrence which will run backwards
   */
  private static HolonomicRecurrence reverse(HolonomicRecurrence holRec, int initSize) {
    ArrayList<Z[]> polyList = holRec.getPolyList();
    ArrayList<Z[]> rPolyList = new ArrayList<Z[]>(16);
    rPolyList.add(polyList.get(0)); // the constant
    int ind = 0;
    for (ind = polyList.size() - 1;  ind >= 1; ind --) { // polynomials
      rPolyList.add(polyList.get(ind));
    } // for ind - polynomials

    Z[] initTerms = holRec.getInitTerms();
    Z[] rInitTerms = new Z[initSize];
    int rind = 0;
    ind = initTerms.length - 1;
    while (ind >= 0 && rind < initSize) { // initial terms
      rInitTerms[rind ++] = initTerms[ind --];
    } // while initial terms
    return new HolonomicRecurrence(holRec.getOffset(), rPolyList, rInitTerms, holRec.getDistance());
  } // reverse(HolonomicRecurrence,int)

  /**
   * Reverse <code>this</code> recurrence, that is
   * reverse the order of the polynomials and of all initial terms,
   * but do not change any sign.
   * @param holRec instance to be reversed
   * @return a new HolonomicRecurrence which will run backwards
   */
  private static HolonomicRecurrence reverse(HolonomicRecurrence holRec) {
    return reverse(holRec, holRec.getInitTerms().length);
  } // reverse(HolonomicRecurrence)

  /**
   * Gets a String representation
   * of the coefficient polynomials.
   * @param holRec instance to be evaluated
   * @return a list of polynomials of the form "[[0,1],[1,2],[1]]".
   */
  private static String getPolyString(HolonomicRecurrence holRec) {
    StringBuffer result = new StringBuffer(256);
    ArrayList<Z[]> polyList = holRec.getPolyList();
    for (int i = 0; i < polyList.size(); i ++) { // polynomials
      Z[] poly = polyList.get(i);
      result.append(i == 0 ? '[' : ',');
      for (int j = 0; j < poly.length; j ++) {
        result.append(j == 0 ? '[' : ',');
        result.append(poly[j].toString());
      } // for j
      result.append(']');
    } // for i
    result.append(']');
    return result.toString();
  } // getPolyString

  /**
   * Gets a String representation
   * of the initial terms.
   * @param holRec instance to be evaluated
   * @param offset starting index (first is 0)
   * @param len number of terms to be included
   * @return a list of terms of the form "[0,1,1,2,1]".
   */
  private static String getInitString(HolonomicRecurrence holRec, int offset, int len) {
    StringBuffer result = new StringBuffer(256);
    Z[] initTerms = holRec.getInitTerms();
    int j = 0;
    while (j < len) {
      if (offset + j < initTerms.length) {
        result.append(j == 0 ? '[' : ',');
        result.append(initTerms[offset + j].toString());
      } else {
        // System.out.println("# signature longer (" + String.valueOf(offset + j) + ") than initTerms (" + initTerms.length + ")");
        result.append(",??");
        j = len; // break loop
      }
      j ++;
    } // while j
    result.append(']');
    return result.toString();
  } // getInitString(int, int)

  /**
   * Gets a String representation
   * of the initial terms.
   * @param holRec instance to be evaluated
   * @param len number of terms to be included
   * @return a list of terms of the form "[0,1,1,2,1]".
   */
  private static String getInitString(HolonomicRecurrence holRec, int len) {
    return getInitString(holRec, 0, len);
  } // getInitString(int)

  /**
   * Gets a String representation
   * of the initial terms.
   * @param holRec instance to be evaluated
   * @return a list of terms of the form "[0,1,1,2,1]".
   */
  private static String getInitString(HolonomicRecurrence holRec) {
    return getInitString(holRec, 0, holRec.getInitTerms().length);
  } // getInitString()

  /**
   * Evaluate a HolonomicRecurrence and gets a list
   * 22of the resulting data terms.
   * @param holRec instance to be evaluated
   * @param numTerms how many terms should be returned
   * @return a list of terms of the form "0,1,1,2,3,5,8".
   */
  private static String getDataList(HolonomicRecurrence holRec, int numTerms) {
    StringBuffer result = new StringBuffer(256);
    int n = 0;
    boolean busy = true;
    while (n < numTerms && busy) {
      Z term = holRec.next();
      if (term != null) {
        result.append(term.toString());
        result.append(',');
      } else {
        result.append("null,");
        busy = false; // break loop
      }
      n ++;
    } // while n
    result.deleteCharAt(result.length() - 1); // remove last comma
    return result.toString();
  } // getDataList

  /** 
   * Compute the initial terms of an ordinary (rational) generating function.
   * @param offset number of leading zeroes in <code>nums</code> and initial terms
   * @param nums numerator   as a comma separated list
   * @param dens denominator as a comma separated list
   * @return a new comma separated list with the computed initial termspolynomial
   */
  public static String computeInitialTerms(int offset, String nums, String dens) {
    Z[] temp = ZUtils.toZ(nums);
    int leadz = 0; // number of leading zeroes
    while (leadz < temp.length && temp[leadz].equals(Z.ZERO)) {
      leadz ++;
    } // while leadz
    Z[] pDen = ZUtils.toZ(dens);
    int pDenLen = pDen.length;
    int pNumLen = Math.max(pDenLen, temp.length + leadz); // + offset); // pNum is always same or longer than pDen
    if (sDebug >= 1) {
      System.out.println("# holgf1: nums=" + nums + ", dens=" + dens 
          + ", pNumLen=" + pNumLen + ", pDenLen=" + pDenLen);
    }
    Z[] pNum = new Z[pNumLen]; // accumulate new initial terms here
    for (int ind = 0; ind < pNumLen; ind ++) { // copy all coefficients (polynomials of degree 0)
      pNum[ind] = ind < temp.length ? temp[ind] : Z.ZERO;
    } // for ind - copy
    
    final Z divisor = pDen[0];
    if (divisor.equals(Z.ZERO)) {
      throw new IllegalArgumentException("divisor is zero");
    }
    StringBuffer nInits = new StringBuffer(256);
    for (int inum = 0; inum < pNumLen; inum ++) { // compute new initial terms
      // similiar code in GeneratingFunctionSequence.next()
      final Z[] quotRest = pNum[inum].divideAndRemainder(divisor);
      nInits.append(',');
      nInits.append(quotRest[0].toString());
      final Z factor = quotRest[0].negate();
      if (! quotRest[1].equals(Z.ZERO)) {
        throw new IllegalArgumentException("no even division");
      }
      for (int iden = 0; iden < pDenLen; iden ++) {
        int knum = inum + iden;
        if (knum < pNumLen) {
          pNum[knum] = pNum[knum].add(pDen[iden].multiply(factor));
        }
      } // for iden
      if (sDebug >= 1) {
        System.out.println("# holgf2: factor=" + factor 
            + ", summand= " + pDen[0].multiply(factor)
            + ", pnum[" + inum + "]=" + pNum[inum]);
      }
    } // for inum - compute
    return nInits.substring(1); //  + 2 * offset); // remove leading zeroes
  } // computeInitialterms
  
  /**
   * Process one input line, and determine
   * whether it should be written to the output.
   * The following <code>callCode</code>s are processed:
   * <ul>
   * <li><code>holgf</code> - GeneratingFunction parameters -&gt; HolonomicRecurrence
   * <li><code>holog</code> - determine the prefixed initial terms</li>
   * <li><code>holor</code> - try to evaluate the recurrence backwards</li>
   * <li><code>holos</code> - evaluate the recurrence <code>numTerms</code> times</li>
   * </ul>
   */
  private void processRecord() {
    boolean result = false;
    mInitString = ""; // initial terms for a(n)
    int n = 0; // index of the next sequence element to be computed
    mPolyString = ""; // polynomials as coefficients of <code>n^i, i=0..m</code>
    // input record is: aseqno callCode mOffset polyList initTerms mNDist data
    iparm = 2;
    try {
      mOffset = Integer.parseInt(parms[iparm ++]); // [2]
      mPolyString = parms[iparm ++];  // [3]
      mInitString = parms[iparm ++]; // [4]
      mNDist = 0;
      mNDist = Integer.parseInt(parms[iparm ++]); // [5]
    } catch (Exception exc) {
    }

    if (false) {
        
    } else if (callCode.startsWith("holgf")) { // GeneratingFunction parameters -> HolonomicRecurrence
      // parameters are numerator, denominator polynomials
      String temp = mPolyString;
      mPolyString = mInitString;
      mInitString = temp; // exchange both
      int iparm = 1;
      parms[iparm ++] = callCode + "1";
      parms[iparm ++] = String.valueOf(mOffset);
      parms[iparm ++] = reverse("[" + mPolyString + ",0]");
      parms[iparm ++] = "[" + computeInitialTerms(mOffset, mInitString, mPolyString) + "]"; // nums. densgetInitString (mHolRec);
      parms[iparm ++] = "0";
      reproduce();

    } else if (callCode.startsWith("holog")) { // determine the prefixed initial terms
      mHolRec = new HolonomicRecurrence(mOffset, mPolyString, mInitString, mNDist); // instance to be tested
      Z[] sInits = mHolRec.getInitTerms(); // initial terms from 'stripped'
      int termNo = sInits.length;
      Z[] nInits = new Z[termNo];
      HolonomicRecurrence rHolRec = reverse(mHolRec, mHolRec.getPolyList().size());
      int iterm = termNo - 1; // start at the end
      Z rTerm = rHolRec.next();
      if (sDebug >= 1) {
        System.out.println(aseqno + "\t" + getPolyString(rHolRec) + "\t" + getInitString(rHolRec));
        System.out.println("sInits[" + iterm + "]=" + sInits[iterm].toString()
            + ", rTerm=" + (rTerm == null ? "null" : rTerm.toString()));
      }
      while (iterm >= 0 && rTerm != null && rTerm.equals(sInits[iterm])) {
        if (sDebug >= 1) {
          System.out.println("sInits[" + iterm + "]=" + sInits[iterm].toString()
              + ", rTerm=" + (rTerm == null ? "null" : rTerm.toString()));
        }
        rTerm = rHolRec.next();
        iterm --;
      } // while iterm
      if (sDebug >= 1) {
        System.out.println("stopping rTerm= " + (rTerm == null ? "null" : rTerm.toString()));
      }
      int offset = iterm + 1;
      int len    = mHolRec.getOrder();
      parms[1] = callCode + "1";
      if (offset == 0) {
        parms[4] =  getInitString(mHolRec, 0, len)      .replaceAll("\\[", "[  ");
      } else {
        parms[4] = (getInitString(mHolRec, 0, offset)
                  + getInitString(mHolRec, offset, len)).replaceAll("\\]\\[", ",  ");
      }
      reproduce();

    } else if (callCode.startsWith("holor")) { // getTermList(reverse)
      mHolRec = new HolonomicRecurrence(mOffset, mPolyString, mInitString, mNDist); // instance to be tested
      HolonomicRecurrence rHolRec = reverse(mHolRec);
      parms[3] = getPolyString (rHolRec);
      parms[4] = getInitString(rHolRec);
      reproduce(6);
      System.out.println(aseqno + "\t" + callCode + "1" + "\t" + mOffset + "\t" + getDataList(rHolRec, numTerms));
      System.out.println(aseqno + "\t" + "========"); // will remain there even after sort

    } else if (callCode.startsWith("holos")) { // getTermList
      mHolRec = new HolonomicRecurrence(mOffset, mPolyString, mInitString, mNDist); // instance to be tested
      System.out.println(aseqno + "\t" + callCode + "1" + "\t" + mOffset + "\t" + getDataList(mHolRec, numTerms));

    } else {
      reproduce();
      System.out.println(aseqno + "\t" + "unknown callcode \"" + callCode + "\"");
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
          if (sDebug >= 1) {
            System.out.println(line); // repeat it unchanged
          }
          iparm = 0;
          aseqno   = parms[iparm ++];
          callCode = parms[iparm ++];
          try {
            mOffset = 0;
            mOffset = Integer.parseInt(parms[iparm ++]);
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
   * Main method, filters a file and writes the copy to STDOUT.
   * @param args command line arguments:
   * <ul>
   * <li>-d level debugging level (default 0=none, 1=some, 2=more)</li>
   * <li>-f filename input file or "-" or none for STDIN</li>
   * <li>-i initTerms initial terms</li>
   * <li>-n numTerms number of terms to be computed (default: 16)</li>
   * <li>-p polyList list of vectors for coefficient polynomials in n</li>
   * </ul>
   */
  public static void main(String[] args) {
    int iarg = 0;
    HolonomicRecurrenceTest holTest = new HolonomicRecurrenceTest();
    holTest.numTerms = 16;
    holTest.mOffset  = 0;
    String fileName  = "-"; // assume STDIN
    String polyList  = null;
    String initTerms = null;
    while (iarg < args.length) { // consume all arguments
      String opt = args[iarg ++];
      try {
        if (false) {
        } else if (opt.equals    ("-d")     ) {
          sDebug = 1;
          try {
              sDebug = Integer.parseInt(args[iarg ++]);
          } catch (Exception exc) { // take default
          }
        } else if (opt.equals    ("-f")     ) {
          fileName = args[iarg ++];
        } else if (opt.equals    ("-i")     ) {
          initTerms = args[iarg ++];
        } else if (opt.equals    ("-n")     ) {
          holTest.numTerms = Integer.parseInt(args[iarg ++]);
        } else if (opt.equals    ("-o")     ) {
          holTest.mOffset  = Integer.parseInt(args[iarg ++]);
        } else if (opt.equals    ("-p")     ) {
          polyList = args[iarg ++];

        } else {
          System.err.println("??? invalid option: \"" + opt + "\"");
        }
      } catch (Exception exc) { // take default
      }
    } // while args
    if (polyList != null) {
      holTest.mHolRec = new HolonomicRecurrence(0, polyList, initTerms, 0);
      System.out.println(holTest.getDataList(holTest.mHolRec, holTest.numTerms));
    } else {
      holTest.processFile(fileName);
    }
  } // main

} // HolonomicRecurrenceTest

