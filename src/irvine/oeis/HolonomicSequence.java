/* Holonomic sequences where the recurrence equation for a(n) has polynomials in n as coefficients.
 * @(#) $Id$
 * 2019-04-12, Georg Fischer
 */
package irvine.oeis;

import java.util.ArrayList;
import irvine.math.z.Z;
import irvine.math.z.ZUtils;

/**
 * A Holonomic sequence is defined by a recurrence equation 
 * where the factors of <em>a[n-i], i= 0..k-1</em> are not constant
 * like in LinearRecurrence.java.
 * The equation is written in the form of an <em>annihilator</em>:
 * <pre>
 * p[0]*a[n] + p[1]*a[n+1] + ... + p[k]*a[n+k-1] = 0
 * </pre>
 * <em>k</em> is the order of the recurrence, 
 * and <em>p[i], i= 0..k-1</em> are polynomials in <em>n</em>.
 * @author Georg Fischer
 */
public class HolonomicSequence implements Sequence {
  protected int debug = 1;
  
  protected int mIndex; // index of next term to be generated
  protected Z[] mInitTerms; // initial terms for a(n)
  protected int mLeadShift; // index distance between the highest recurrence element and a[n]: 0..k-1 
  protected int mMaxDegree; // maximum degree of polynomials in n
  protected int mN; // running index for the sequence
  protected Z[] mNPowers; // powers of mN for exponents 0..mMaxDegree
  protected int mOffset; // index of the first sequence element
  protected int mOrder; // order of the recurrence, number of sequence elements which are involved
  protected ArrayList<Z[]> mPoly; // polynomials as coefficients of <em>n^i, i=0..m</em>
  protected Z[] mRing; // ring buffer for the elements involved in the recurrence, indexed with mN modulo mOrder
  
  /** 
   * Empty constructor
   */
  protected HolonomicSequence() { 
    mOffset = 0;
    mLeadShift = 0;
    mPoly = new ArrayList<Z[]>(16);
    mInitTerms = new Z[] { Z.valueOf(0) };
    initialize();
  }

  /**
   * Construct a holonomic sequence from Z parameters.
   * @param offset first valid term has this index
   * @param poly polynomials as coefficients of <em>n^i, i=0..m</em>
   * @param initTerms initial values of a[0..k]
   * @param leadShift index distance between the highest recurrence element and a[n]: 0..k-1 
   */
  public HolonomicSequence(final int offset, final ArrayList<Z[]> poly, final Z[] initTerms, final int leadShift) {
    mOffset    = offset;
    mLeadShift = leadShift;
    mPoly      = poly;
    mInitTerms = initTerms;
    initialize();
  } // Constructor

  /**
   * Construct a holonomic sequence from String parameters.
   * @param offset first valid term has this index
   * @param matrix polynomials as coefficients of <em>n^i, i=0..m</em>, 
   * as an array of String vectors, for example "[[0,1,2],[0],[17,0,18]]"
   * @param initTerms initial values of a[0..k], as a String vector, for example "[0,1,2,3]"
   * @param leadShift index distance between the highest recurrence element and a[n]: 0..k-1 
   */
  public HolonomicSequence(final int offset, final String matrix, final String initTerms, final int leadShift) {
    mOffset    = offset;
    mLeadShift = leadShift;
    int start = 0;
    while (matrix.charAt(start) == '[') {
      ++ start;
    }
    int behind = matrix.length();
    while (matrix.charAt(behind - 1) == ']') {
      -- behind;
    }
    final String[] polys = matrix.substring(start, behind).split("\\]\\s*\\,\\s*\\[");
    mPoly = new ArrayList<Z[]>(16);
    for (int k = 0; k < polys.length; k ++) {
      mPoly.add(ZUtils.toZ(polys[k]));
    } // for k
    mInitTerms = ZUtils.toZ(initTerms);
    initialize();
  } // Constructor

  /**
   * Initialize the sequence. 
   * This code is common to all constructors
   */
  private void initialize() {
    mN = mOffset - 1;
    mMaxDegree = 1;
    mOrder = mPoly.size();
    mRing = new Z[mOrder];
    for (int k = 0; k < mOrder; k ++) { // determine mMaxDegree
      int klen = mPoly.get(k).length;
      if (klen > mMaxDegree) {
        mMaxDegree = klen;
      }
    } // for k
    mNPowers = new Z[mMaxDegree];
    mNPowers[0] = Z.ONE;
  } // initialize
  
  /**
   * Gets the next term of the sequence.
   */
  @Override
  public Z next() {
    Z result = null;
    mN ++;
    if (mN < mInitTerms.length) {
      result = mInitTerms[mN];
    } else {
      mNPowers[1] = Z.valueOf(mN);
      for (int m = 2; m < mMaxDegree; m ++) { // fill powers of mN
        mNPowers[m] = mNPowers[m - 1].multiply(mN);
      } // for powers of mN
      int ilead = mN + mLeadShift;
      int k = mOrder - 1;
      Z divisor = evalCoefficient(k --);
      result = Z.ZERO;
      while (k >= 0) {
        result = result.add(evalCoefficient(k)
            .multiply(mRing[(mN + mLeadShift + k - mOrder) % mOrder]));
        k --;
      } // while k
      Z[] quotRemd = result.negate().divideAndRemainder(divisor);
      if (! quotRemd[1].equals(Z.ZERO)) {
      	System.out.println("assertion: division with rest" + quotRemd[1].toString());
      }
      result = quotRemd[0];
    }
    mRing[mN % mOrder] = result;
    return result;
  } // next
  
  /**
   * Evaluates the polynomial in {@link #mN} which is some recurrence coefficient
   * @param k index of the coefficient, 0 &lt;= k &lt; {@link #mOrder}
   * @return value of the polynomial
   */
  private Z evalCoefficient(int k) {
    Z result = Z.ZERO;
    Z[] poly = mPoly.get(k);
    for (int i = poly.length - 1; i >= 0; i --) {
      Z factor = poly[i];
      if (       factor.equals(Z.ZERO   )) {
        // ignore
      } else if (factor.equals(Z.ONE    )) {
        result = result.add(mNPowers[i]);
      } else if (factor.equals(Z.NEG_ONE)) {
        result = result.subtract(mNPowers[i]);
      } else {
        result = result.add(mNPowers[i].multiply(factor));
      }
    } // for i
    if (debug >= 1) { System.out.println("evalCoefficient(k)=" + result); }
    return result;
  } // evalCoefficient
  
  /** 
   * Test method
   * @param args command line arguments: offset, matrix, initTerms, leadShift
   */
  public static void main(String[] args) {
    int maxTerms = 16;
    int offset = 0;
    int leadShift = 0;
    String matrix    = "[[1,2],[0], [0,18,0,17]]";
    String initTerms = "[1,2,6]";
    HolonomicSequence holo = new HolonomicSequence();
    holo = new HolonomicSequence(offset, matrix, initTerms, leadShift);

    int iarg = 0;
    try {
      offset    = Integer.parseInt(args[iarg ++]);
      matrix    = args[iarg ++];
      initTerms = args[iarg ++];
      leadShift = Integer.parseInt(args[iarg ++]);
    } catch (Exception exc) {
    }
    holo = new HolonomicSequence(offset, matrix, initTerms, leadShift);
    int n = 0;
    while (n < maxTerms) {
      System.out.println(n + " " + holo.next().toString());
      n ++;
    } // while n
  } // main
  
} // HolonomicSequence
