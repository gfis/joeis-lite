/* Holonomic sequences where the recurrence equation for a(n)
 * has polynomials in n as coefficients.
 * @(#) $Id$
 * 2019-12-17: Constructors with prefix
 * 2019-12-08: optimize for the linear case
 * 2019-12-07, Sean Irvine: jOEIS conventions
 * 2019-12-04, Georg Fischer
 */
package irvine.oeis;

import java.util.ArrayList;

import irvine.math.z.Z;
import irvine.math.z.ZUtils;

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
 * @author Georg Fischer
 */
public class HolonomicRecurrence implements Sequence {
  public static int sDebug = 0;

  protected Z[] mInitTerms; // initial terms for a(n)
  protected int mNDist; // d >= 0 when a(n+d) is the highest and next element to be computed (0 <= d <= k).
  protected int mMaxDegree; // maximum degree of polynomials in n; = 0 for linear recurrences
  protected int mN; // index of the next sequence element to be computed
  protected Z[] mNdPowers; // powers of mNDist for exponents 0..mMaxDegree
  protected int mOffset; // index of the first sequence element
  protected int mOrder; // order k-1 of the recurrence, number of previous sequence elements used to compute a(n)
  protected ArrayList<Z[]> mPolyList; // polynomials as coefficients of <code>n^i, i=0..m</code>
  protected Z[] mBuffer; // ring buffer for the elements involved in the recurrence, indexed with mN modulo mOrder
  protected int mBufSize; // size of the ring buffer
  /**
   * Empty constructor.
   */
  protected HolonomicRecurrence() {
    mOffset = 0;
    mNDist = 0;
    mPolyList = new ArrayList<Z[]>(16);
    mInitTerms = new Z[] {Z.ZERO};
    initialize();
  }

  /**
   * Construct a holonomic recurrence sequence from Z parameters.
   *
   * @param offset    first valid term has this index
   * @param polyList  polynomials as coefficients of <code>n^i, i=0..m</code>
   * @param initTerms initial values of <code>a[0..k]</code>
   * @param nDist     index distance between the highest recurrence element and <code>a[n]: 0..k-1</code>
   */
  public HolonomicRecurrence(final int offset, final ArrayList<Z[]> polyList, final Z[] initTerms, final int nDist) {
    mOffset = offset;
    mNDist = nDist;
    mPolyList = polyList;
    mInitTerms = initTerms;
    initialize();
  } // Constructor

  /**
   * Construct a holonomic recurrence sequence from Z parameters.
   *
   * @param offset    first valid term has this index
   * @param polyList  polynomials as coefficients of <code>n^i, i=0..m</code>
   * @param initTerms initial values of <code>a[0..k]</code>
   */
  public HolonomicRecurrence(final int offset, final ArrayList<Z[]> polyList, final Z[] initTerms) {
    this(offset, polyList, initTerms, 0);
  } // Constructor

  /**
   * Construct a holonomic recurrence sequence from String parameters.
   *
   * @param offset    first valid term has this index
   * @param matrix    polynomials as coefficients of <code>n^i, i=0..m</code>,
   *                  as an array of String vectors, for example "[[0,1,2],[0],[17,0,18]]"
   *                  in the holonomic case, or a simple vector "[0,1,2]" in the linear case.
   *                  The brackets must be spedified accordingly.
   * @param initTerms initial values of a[0..k], as a String vector, for example "[0,1,2,3]"
   * @param nDist     index distance between the highest recurrence element and a[n]: 0..k-1
   */
  public HolonomicRecurrence(final int offset, final String matrix, final String initTerms, final int nDist) {
    mOffset = offset;
    mNDist = nDist;
    int start = 0;
    while (matrix.charAt(start) == '[') {
      ++start;
    }
    int behind = matrix.length();
    while (matrix.charAt(behind - 1) == ']') {
      --behind;
    }
    mPolyList = new ArrayList<Z[]>(16);
    if (start <= 1) { // linear case, simple vector of the form "[0,1,2,...]"
      final String[] polys = matrix.substring(start, behind).split("\\s*,\\s*");
      for (int k = 0; k < polys.length; ++k) {
        if (sDebug >= 1) {
          System.out.println("polys[" + k + "]=" + polys[k]);
        }
        mPolyList.add(new Z[] {new Z(polys[k])});
      } // for k
    } else { // holonomic case, vector list "[[0,1,2],[0],[17,0,18]]"
      final String[] polys = matrix.substring(start, behind).split("]\\s*,\\s*\\[");
      for (int k = 0; k < polys.length; ++k) {
        if (sDebug >= 1) {
          System.out.println("polys[" + k + "]=" + polys[k]);
        }
        mPolyList.add(ZUtils.toZ(polys[k]));
      } // for k
    }
    mInitTerms = ZUtils.toZ(initTerms);
    initialize();
  } // Constructor

  /**
   * Construct a holonomic recurrence sequence from String parameters.
   *
   * @param offset    first valid term has this index
   * @param matrix    polynomials as coefficients of <code>n^i, i=0..m</code>,
   *                  as an array of String vectors, for example "[[0,1,2],[0],[17,0,18]]"
   *                  in the holonomic case, or a simple vector "[0,1,2]" in the linear case.
   *                  The brackets must be spedified accordingly.
   * @param prefix    initial values of the sequence which do not participate in the recurrence
   * @param initTerms initial values of a[0..k], as a String vector, for example "[0,1,2,3]"
   * @param nDist     index distance between the highest recurrence element and a[n]: 0..k-1
   */
  public HolonomicRecurrence(final int offset, final String matrix, final String prefix, final String initTerms, final int nDist) {
    this(offset, matrix, (prefix + "," + initTerms).replaceAll("\\s*\\]\\s*\\,\\s*\\[\\s*", ","), nDist);
  } // Constructor

  /**
   * Construct a holonomic recurrence sequence from String parameters.
   *
   * @param offset    first valid term has this index
   * @param matrix    polynomials as coefficients of <code>n^i, i=0..m</code>,
   *                  as an array of String vectors, for example "[[0,1,2],[0],[17,0,18]]"
   *                  in the holonomic case, or a simple vector "[0,1,2]" in the linear case.
   *                  The brackets must be spedified accordingly.
   * @param prefix    initial values of the sequence which do not participate in the recurrence
   * @param initTerms initial values of a[0..k], as a String vector, for example "[0,1,2,3]"
   */
  public HolonomicRecurrence(final int offset, final String matrix, final String prefix, final String initTerms) {
    this(offset, matrix, ((prefix.length() == 0 || prefix.equals("[]") ? "" : prefix + ",") 
        + initTerms).replaceAll("\\s*\\]\\s*\\,\\s*\\[\\s*", ","), 0);
  } // Constructor

  /**
   * Construct a holonomic recurrence sequence from String parameters.
   *
   * @param offset    first valid term has this index
   * @param matrix    polynomials as coefficients of <code>n^i, i=0..m</code>,
   *                  as an array of String vectors, for example "[[0,1,2],[0],[17,0,18]]"
   *                  in the holonomic case, or a simple vector "[0,1,2]" in the linear case.
   *                  The brackets must be spedified accordingly.
   * @param initTerms initial values of a[0..k], as a String vector, for example "[0,1,2,3]"
   */
  public HolonomicRecurrence(final int offset, final String matrix, final String initTerms) {
    this(offset, matrix, initTerms, 0);
  } // Constructor

  /**
   * Initialize the sequence.
   * This code is common to all constructors.
   */
  private void initialize() {
    mN = mOffset - 1;
    mMaxDegree = 1;
    int k = mPolyList.size() - 1;
    mBufSize = k + 2; // at least 1
    mBuffer = new Z[mBufSize];
    for (int ibuf = 0; ibuf < mBufSize; ibuf ++) {
      mBuffer[ibuf] = Z.ZERO; // why? accessed and null for A027770
    }
    mOrder = k - 1;
    if (sDebug >= 1) {
      System.out.println("order=" + mOrder);
    }
    while (k >= 0) { // determine mMaxDegree
      int klen = mPolyList.get(k).length;
      if (klen > mMaxDegree) {
        mMaxDegree = klen;
      }
      --k;
    } // while k
    mNdPowers = new Z[mMaxDegree + 2]; // ensure that [0], [1] always exist
    mNdPowers[0] = Z.ONE;
  } // initialize

  /**
   * Gets the next term of the sequence.
   */
  @Override
  public Z next() {
    int ibuf; // index in mBuffer
    final Z result;
    ++mN;
    if (mN - mOffset < mInitTerms.length) {
      result = mInitTerms[mN - mOffset];
    } else {
      int nd = mN - mNDist;
      mNdPowers[1] = Z.valueOf(nd);
      for (int m = 2; m < mMaxDegree; ++m) { // fill powers of mN
        mNdPowers[m] = mNdPowers[m - 1].multiply(nd);
      } // for powers of mN
      int k = mPolyList.size() - 1;
      final Z[] pvals = new Z[k + 1];
      while (k >= 0) { // evaluate all polynomials
        Z pvalk = Z.ZERO; // one coefficient = value of a polynomial in n
        final Z[] poly = mPolyList.get(k);
        // handle the linear case separately
        Z coeffi = poly[0];
        if (!coeffi.equals(Z.ZERO)) {
          pvalk = pvalk.add(coeffi);
        }
        for (int i = 1; i < poly.length; i++) { // possibly holonomic: evaluate polynomial in nd
          coeffi = poly[i];
          if (coeffi.equals(Z.ZERO)) {
            // ignore
          } else if (coeffi.equals(Z.ONE)) {
            pvalk = pvalk.add(mNdPowers[i]);
          } else if (coeffi.equals(Z.NEG_ONE)) {
            pvalk = pvalk.subtract(mNdPowers[i]);
          } else { // abs(coeffi) > 1
            pvalk = pvalk.add(mNdPowers[i].multiply(coeffi));
          }
        } // for i - terms of one polynomial in nd
        pvals[k] = pvalk;
        if (sDebug >= 1) {
          System.out.println("pvals[" + k + "]=" + pvals[k]);
        }
        --k;
      } // while k - coefficients of the recurrence
      // pvals[0..mOrder] now contain the coefficients of the recurrence equation
      Z sum = pvals[0]; // k=0, the constant term (without a(k)) in the recurrence, mostly ZERO
      for (k = 1; k <= mOrder; ++k) { // sum all previous elements of the recurrence
        ibuf = mN - mOrder - 1 + k; // index of previous recurrence element a[n-i]
        while (ibuf < 0) {
          ibuf += mBufSize;
        }
        ibuf %= mBufSize;
        if (sDebug >= 1) {
          System.out.println("mN=" + mN + ", nd=" + nd + ", k=" + k 
              + ", mBufSize=" + mBufSize + ", mOrder=" + mOrder);
          System.out.println("    mBuffer[" +  ibuf + "]=" + mBuffer[ibuf] + ", old_sum=" + sum);
        }
        sum = sum.add(pvals[k].multiply(mBuffer[ibuf]));
        if (sDebug >= 1) {
          System.out.println("new_sum=" + sum);
        }
      } // for k - summing
      if (! pvals[mOrder + 1].equals(Z.ZERO)) {
        final Z[] quotRemd = sum.negate().divideAndRemainder(pvals[mOrder + 1]);
        if (!quotRemd[1].equals(Z.ZERO)) {
          if (sDebug >= 1) {
            System.out.println("assertion: division with rest " + quotRemd[1].toString());
          }
          result = null;
        } else {
          result = quotRemd[0];
        }
      } else {
        if (sDebug >= 1) {
          System.out.println("assertion: division by zero " );
        }
        result = null;
      }
    }
    ibuf = mN;
    while (ibuf < 0) {
       ibuf += mBufSize;
    }
    ibuf %= mBufSize;
    mBuffer[ibuf] = result;
    return result;
  } // next

  /**
   * Gets the offset
   * @return the index where the sequence elements start
   */
  public int getOffset() {
    return mOffset;
  }

  /**
   * Gets the order of <code>this</code> recurrence
   * @return number of sequence elements in the recurrence equation, minus one.
   * The vector for the equation has an additional element for the constant,
   * and another for the new sequence element to be computed.
   * @return a number &gt;= 0
   */
  public int getOrder() {
    return mOrder;
  }

  /**
   * Gets the vectors for the cofficient polynomials.
   * @return a list of coefficient vectors for the powers of <code>n</code>.
   */
  public ArrayList<Z[]> getPolyList() {
    return mPolyList;
  }

  /**
   * Gets the vector for the initial terms.
   * @return a vector for the initial values of the sequence.
   */
  public Z[] getInitTerms() {
    return mInitTerms;
  }

  /**
   * Gets the index distance between the highest recurrence element and a[n]: 0..k-1
   * @return a non-negative number
   */
  public int getDistance() {
    return mNDist;
  }

} // HolonomicRecurrence