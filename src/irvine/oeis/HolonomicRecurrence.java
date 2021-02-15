/* Holonomic sequences where the recurrence equation for a(n) has polynomials in n as coefficients.
 * @(#) $Id$
 * 2021-02-15: complete rewrite b.o. REVERSE 
 * 2021-02-03: imply "[1]" for empty initTerms
 * 2020-09-24: gftype=2, adjunct(n) to be added to the constant term
 * 2020-07-20, Georg Fischer: public getInitTerms(), protected initialize()
 * 2020-04-13, Sean Irvine: jOEIS conventions
 * 2020-04-10: merge with joeis; gfType "egf"
 * 2020-01-07: preset mBuffer with ZEROes because of problems; also for single/self start
 * 2019-12-17: Constructors with prefix
 * 2019-12-08, Georg Fischer: optimize for the linear case
 * 2019-12-07, Sean Irvine: jOEIS conventions
 * 2019-12-04, Georg Fischer
 */
package irvine.oeis;

import java.util.ArrayList;
import java.util.Arrays;

import irvine.math.z.Z;
import irvine.math.z.ZUtils;

/**
 * A holonomic sequence is defined by a recurrence equation
 * where the factors of <code>a[n-i], i=0..k</code> are either constant
 * (like in <code>LinearRecurrence.java</code>), or are polynomials in <code>n</code>..
 * The equation is written in the form of an <code>annihilator</code>:
 * <pre>
 * p[0]*1 + p[1]*a[n-k+1] + p[2]*a[n-k+2] + ...+ p[k-1]*a[n-k+k-1] + p[k]*a[n] = 0
 * </pre>
 * <code>k-1</code> is the order of the recurrence,
 * and <code>p[i], i= 0..k</code> are the polynomials (or constants) in <code>n</code>.
 * <code>a[n]</code> is the next term to be computed.
 * The recurrence equation may have a term <code>p[0]</code> which is independent
 * of any sequence term.
 * @author Georg Fischer
 */
public class HolonomicRecurrence implements Sequence {
  static int sDebug = 0;

  protected Z[] mInitTerms; // initial terms for a(n)
  protected int mShift; // d >= 0 such that a(n+d) is the highest and next element to be computed (0 <= d <= k).
  protected int mN; // index of the next sequence element to be computed
  protected int mNPlen; // maximum degree + 1 of polynomials in n; = 1 for linear recurrences
  protected Z[] mNPowers; // powers of n for exponents 0..mNPlen-1; [0] = n^0 = 1
  protected int mOffset; // index of the first sequence element
  protected int mOrder; // order k-1 of the recurrence, number of previous sequence elements used to compute a(n)
  protected ArrayList<Z[]> mPolyList; // polynomials as coefficients of <code>n^i, i=0..m</code>
  protected int mLinit; // limit for processing of initial terms
  protected int mGfType; // bit mask for type(s) of the g.f.: 0 = ordinary, 1 = exponential, 2 = adjunct, 4 = reverse ...

  /**
   * Empty constructor.
   */
  protected HolonomicRecurrence() {
    mOffset = 0;
    mShift = 0;
    mPolyList = new ArrayList<>(16);
    mInitTerms = new Z[] { Z.ONE };
    initialize();
  }

  /**
   * Construct a holonomic recurrence sequence from Z parameters.
   *
   * @param offset    first valid term has this index
   * @param polyList  polynomials as coefficients of <code>n^i, i=0..m</code>
   * @param initTerms initial values of <code>a[0..k]</code>
   * @param shift     index distance between the highest recurrence element and <code>a[n]: 0..k-1</code>
   */
  public HolonomicRecurrence(final int offset, final ArrayList<Z[]> polyList, final Z[] initTerms, final int shift) {
    mOffset = offset;
    mShift = shift;
    mPolyList = polyList;
    mInitTerms = initTerms.length == 0 ? new Z[] { Z.ONE } : Arrays.copyOf(initTerms, initTerms.length);
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
   *                  The brackets must be specified accordingly.
   * @param initTerms initial values of a[0..k], as a String vector, for example "[0,1,2,3]"
   * @param shift     index distance between the highest recurrence element and a[n]: 0..k-1
   */
  public HolonomicRecurrence(final int offset, final String matrix, final String initTerms, final int shift) {
    mOffset = offset;
    mShift = shift;
    int start = 0;
    while (matrix.charAt(start) == '[') {
      ++start;
    }
    int behind = matrix.length();
    while (matrix.charAt(behind - 1) == ']') {
      --behind;
    }
    mPolyList = new ArrayList<>(16);
    if (start <= 1) { // linear case, simple vector of the form "[0,1,2,...]"
      final String[] polys = matrix.substring(start, behind).split("\\s*,\\s*");
      for (int k = 0; k < polys.length; ++k) {
        /**/ if (sDebug >= 1) { System.out.println("polys[" + k + "]=" + polys[k]); }
        mPolyList.add(new Z[] {new Z(polys[k])});
      } // for k
    } else { // holonomic case, vector list "[[0,1,2],[0],[17,0,18]]"
      final String[] polys = matrix.substring(start, behind).split("]\\s*,\\s*\\[");
      for (int k = 0; k < polys.length; ++k) {
        /**/ if (sDebug >= 1) { System.out.println("polys[" + k + "]=" + polys[k]); }
        mPolyList.add(ZUtils.toZ(polys[k]));
      } // for k
    }
    mInitTerms = (initTerms.isEmpty() || "[]".equals(initTerms)) ? new Z[] { Z.ONE } : ZUtils.toZ(initTerms);
    initialize();
  } // Constructor

  /**
   * Construct a holonomic recurrence sequence from String parameters.
   *
   * @param offset    first valid term has this index
   * @param matrix    polynomials as coefficients of <code>n^i, i=0..m</code>,
   *                  as an array of String vectors, for example "[[0,1,2],[0],[17,0,18]]"
   *                  in the holonomic case, or a simple vector "[0,1,2]" in the linear case.
   *                  The brackets must be specified accordingly.
   * @param prefix    initial values of the sequence which do not participate in the recurrence
   * @param initTerms initial values of a[0..k], as a String vector, for example "[0,1,2,3]"
   * @param shift     index distance between the highest recurrence element and a[n]: 0..k-1
   */
  public HolonomicRecurrence(final int offset, final String matrix, final String prefix, final String initTerms, final int shift) {
    this(offset, matrix, (prefix + "," + initTerms).replaceAll("\\s*]\\s*,\\s*\\[\\s*", ","), shift);
  } // Constructor

  /**
   * Construct a holonomic recurrence sequence from String parameters.
   *
   * @param offset    first valid term has this index
   * @param matrix    polynomials as coefficients of <code>n^i, i=0..m</code>,
   *                  as an array of String vectors, for example "[[0,1,2],[0],[17,0,18]]"
   *                  in the holonomic case, or a simple vector "[0,1,2]" in the linear case.
   *                  The brackets must be specified accordingly.
   * @param prefix    initial values of the sequence which do not participate in the recurrence
   * @param initTerms initial values of a[0..k], as a String vector, for example "[0,1,2,3]"
   */
  public HolonomicRecurrence(final int offset, final String matrix, final String prefix, final String initTerms) {
    this(offset, matrix, ((prefix.isEmpty() || "[]".equals(prefix) ? "" : prefix + ",")
        + initTerms).replaceAll("\\s*]\\s*,\\s*\\[\\s*", ","), 0);
  } // Constructor

  /**
   * Construct a holonomic recurrence sequence from String parameters.
   *
   * @param offset    first valid term has this index
   * @param matrix    polynomials as coefficients of <code>n^i, i=0..m</code>,
   *                  as an array of String vectors, for example "[[0,1,2],[0],[17,0,18]]"
   *                  in the holonomic case, or a simple vector "[0,1,2]" in the linear case.
   *                  The brackets must be specified accordingly.
   * @param initTerms initial values of a[0..k], as a String vector, for example "[0,1,2,3]"
   */
  public HolonomicRecurrence(final int offset, final String matrix, final String initTerms) {
    this(offset, matrix, initTerms, 0);
  } // Constructor

  /**
   * Initialize the sequence.
   * This code is common to all constructors.
   */
  protected void initialize() {
    mGfType = ORDINARY; // normally it is an o.g.f.
    mExponentialType = false;
    mAdjunctType = false;
    mReverseType = false;
    mN = mOffset - 1; // one before first initial term
    mNPlen = 1;
    mRElen = mPolyList.size() - 1;
    mRElems = new Z[mRElen + (mRElen == 0 ? 1 : 0)]; // ensure that there is at least mRElems[0]; may not use mRElems.length anymore
    Arrays.fill(mRElems, Z.ZERO);
    mOrder = mRElen - 1; /**/ if (sDebug >= 1) { System.out.println("order=" + mOrder); }
    for (int k = mRElen - 1; k >= 0; --k) { // determine mNPlen
      final int rowLen = mPolyList.get(k).length;
      if (rowLen > mNPlen) {
        mNPlen = rowLen;
      }
    } // while k
    mNPowers = new Z[mNPlen + 1]; // ensure that [0], [1] always exist
    mNPowers[0] = Z.ONE; // n^0 == 1
    initRE(mN);
    mLinit = mInitTerms.length;
    /**/ if (sDebug >= 1) { System.out.println("initialize: mN=" + mN + ", mRElen=" + mRElen + ", mNPlen=" + mNPlen + ", mOrder=" + mOrder + ", mLinit=" + mLinit); }
  } // initialize

  protected static final int ORDINARY = 0;
  protected static final int EXPONENTIAL = 1;
  protected static final int ADJUNCT = 2;
  protected static final int REVERSE = 4;
  protected boolean mExponentialType;
  protected boolean mAdjunctType;
  protected boolean mReverseType;

  /**
   * Get the type(s) of the generating function.
   * @return code (bit mask) for the types:
   * <ul>
   * <li>0 = ordinary</li>
   * <li>1 = exponential</li>
   * <li>2 = use <code>adjunct(n)</code> for some additional function</li>
   * <li>4 = reverse recurrence, start with last initial term and decrease index <code>n</code></li>
   * </ul>
   */
  public int getGfType() {
    return mGfType;
  }

  /**
   * Set the type of the generating function.
   * @param gfType code (bit mask) for the type
   */
  public void setGfType(final int gfType) {
    mGfType = gfType;
    mExponentialType = (mGfType & EXPONENTIAL) == EXPONENTIAL;
    mAdjunctType = (mGfType & ADJUNCT) == ADJUNCT;
    mReverseType = (mGfType & REVERSE) == REVERSE;
    if (mReverseType) {
      mN = mOffset + mInitTerms.length; // one behind last initial term
      initRE(mN);
      mLinit = mInitTerms.length - mRElen;
      /**/ if (sDebug >= 1) { System.out.println("setGfType: mN=" + mN + ", mRElen=" + mRElen + ", mNPlen=" + mNPlen + ", mOrder=" + mOrder + ", mLinit=" + mLinit); }
    }
  }

  /**
   * Set the debugging level.
   * @param level code for the debugging level: 0 = none, 1 = some, 2 = more.
   */
  public static void setDebug(final int level) {
    sDebug = level;
  }

  protected Z[] mRElems; // ring buffer for the elements involved in the recurrence, indexed with mN modulo mRElen
  protected int mRElen; // size of the ring buffer
  protected int mREpos; // current position (index) in the ring buffer

  /**
   * Initializes the position in the ring buffer
   * @param starting position, will be increased/decreased at the beginning of next call of getRE/setRE.
   * This method is called with mN = offset - 1 for normal (increasing),
   * and offset + length(initTerms) for reversed (decreasing) recurrences.
   */
  private void initRE(final int pos) {
    if (mRElen > 0) {
      mREpos = pos;
      while (mREpos < 0) {
        mREpos += mRElen;
      }
      while (mREpos >= mRElen) {
        mREpos -= mRElen;
      }
      // now mREpos inside defined ring buffer range
    }
  } // initRE

  /**
   * Gets the next element from the ring buffer
   * @return the value of a recurrence element a(n-k)
   */
  private Z getRE() {
    if (mReverseType) {
      --mREpos;
      if (mREpos < 0) {
        mREpos = mRElen - 1;
      }
    } else {
      ++mREpos;
      if (mREpos >= mRElen) {
        mREpos = 0;
      }
    }
    return mRElems[mREpos];
  } // getRE

  /**
   * Sets the next element in the ring buffer
   * @param the value of a recurrence element a(n-k)
   */
  private void setRE(final Z an_k) {
    if (mReverseType) {
      --mREpos;
      if (mREpos < 0) {
        mREpos = mRElen - 1;
      }
    } else {
      ++mREpos;
      if (mREpos >= mRElen) {
        mREpos = 0;
      }
    }
    /**/ if (sDebug >= 2 && an_k != null) { System.out.print  ("    setRE(" + mREpos + "," + an_k.toString() + "): " + showRE()); }
    mRElems[mREpos] = an_k;
    /**/ if (sDebug >= 2 && an_k != null) { System.out.println(" -> " + showRE()); }
  } // setRE

  /**
   * Advances the position in the ring buffer without modifying any element
   */
  private void stepRE() {
    if (mReverseType) {
      --mREpos;
      if (mREpos < 0) {
        mREpos = mRElen - 1;
      }
    } else {
      ++mREpos;
      if (mREpos >= mRElen) {
        mREpos = 0;
      }
    }
  } // stepRE

  /**
   * Returns a representation of the ring buffer for debugging purposes
   * @return a String of the form "[a1,*a2,...]"
   */
  private String showRE() {
    final StringBuilder result = new StringBuilder(256);
    result.append('[');
    for (int i = 0; i < mRElen; ++i) { // polynomials
      if (i > 0) {
        result.append(',');
      }
      if (i == mREpos) {
        result.append('*');
      }
      result.append(mRElems[i]);
    } // for i
    result.append(']');
    return result.toString();
  } // showRE

  /**
   * Evaluates the polynomials in n.
   * @param n current index; the n in the polynomials of the recurrence equation
   * @return array of coefficients for the constant and the recurrence elements
   */
  private Z[] evaluatePolynomials(final int n) {
    mNPowers[1] = Z.valueOf(n); // [0] == 1
    for (int m = 2; m <= mNPlen; ++m) { // fill with powers of nd
      mNPowers[m] = mNPowers[m - 1].multiply(n);
    } // fill with n^m

    final Z[] pvals = new Z[mRElen + 1];
    for (int irow = mRElen; irow >= 0; --irow) { // evaluate all polynomials
      final Z[] row = mPolyList.get(irow);
      Z sum = row[0];
      for (int icol = 1; icol < row.length; ++icol) { // possibly holonomic: evaluate polynomial in n
        final Z coeffi = row[icol];
        if (coeffi.isZero()) {
          // ignore
        } else if (coeffi.equals(Z.ONE)) {
          sum = sum.add(mNPowers[icol]);
        } else if (coeffi.equals(Z.NEG_ONE)) {
          sum = sum.subtract(mNPowers[icol]);
        } else { // abs(coeffi) > 1
          sum = sum.add(mNPowers[icol].multiply(coeffi));
        }
      } // for icol - terms of one polynomial in n
      pvals[irow] = sum; /**/ if (sDebug >= 2) { System.out.println("    pvals[" + irow + "]=" + pvals[irow]); }
    } // for irow
    // pvals[0..mRElen] now contain the coefficients of the recurrence equation
    return pvals;
  } // evaluatePolynomials

  /**
   * Gets the next term of the sequence.
   * @return an initial term or the next element computed by the recurrence
   */
  @Override
  public Z next() {
    Z result = null;
    if (mReverseType) { // decreasing
      --mN;
      if (mN - mOffset > mLinit) { // in range
        result = mInitTerms[mN - mOffset];
      } else {
        stepRE(); // -  cf. sum loop below
      }
    } else { // increasing
      ++mN;
      if (mN - mOffset < mLinit) { // in range
        result = mInitTerms[mN - mOffset];
      } else {
        stepRE();
      }
    }
    if (result != null) { // taken from initial terms
    } else { // result == null, not in range of initTerms, must be computed
      final Z[] pvals = evaluatePolynomials(mN - mShift); // coefficients of the recurrence equation

      Z sum = pvals[0]; // the constant term, mostly ZERO
      if (mAdjunctType && mN >= mOrder) {
        sum = sum.add(adjunct(mN));
      }

      int ipvaln = 0; // index of polynomial for new recurrence element
      if (mReverseType) { // decreasing
        ipvaln = 1;
        for (int k = mOrder + 1; k >= 2; --k) { // sum all previous elements of the recurrence
          /**/ if (sDebug >= 1) { System.out.print  ("  sum: " + sum + " (pvals[" + k + "]=" + pvals[k] + ", RE=" + showRE()); }
          sum = sum.add(pvals[k].multiply(getRE()));
          /**/ if (sDebug >= 1) { System.out.println(") -> " + sum + " (pvals[" + k + "]=" + pvals[k] + ", RE=" + showRE()+ ")"); }
        } // for k - summing
        if (!pvals[ipvaln].isZero()) {
          if (mExponentialType && mN >= 2) { // exponential: multiply by mN
            sum = sum.multiply(Z.valueOf(mN));
          }
          final Z[] quotRemd = sum.negate().divideAndRemainder(pvals[ipvaln]);
          if (!quotRemd[1].isZero()) {
            /**/ if (sDebug >= 1) { System.out.println("assertion: division with rest " + quotRemd[1] + " for " + sum.negate() + " / " + pvals[mOrder + 1]); }
            result = null; // end of sequence
          } else {
            result = quotRemd[0];
          }
        } else {
          /**/ if (sDebug >= 1) { System.out.println("assertion: division by zero "); }
          result = null; // end of sequence
        }

      } else { // normal - increasing
        ipvaln = mOrder + 1;
        for (int k = 1; k <= mOrder; ++k) { // sum all previous elements of the recurrence
          /**/ if (sDebug >= 1) { System.out.print  ("  sum: " + sum + " (pvals[" + k + "]=" + pvals[k] + ", RE=" + showRE()); }
          sum = sum.add(pvals[k].multiply(getRE()));
          /**/ if (sDebug >= 1) { System.out.println(") -> " + sum + " (pvals[" + k + "]=" + pvals[k] + ", RE=" + showRE()+ ")"); }
        } // for k - summing
        if (!pvals[ipvaln].isZero()) {
          if (mExponentialType && mN >= 2) { // exponential: multiply by mN
            sum = sum.multiply(Z.valueOf(mN));
          }
          final Z[] quotRemd = sum.negate().divideAndRemainder(pvals[ipvaln]);
          if (!quotRemd[1].isZero()) {
            /**/ if (sDebug >= 1) { System.out.println("assertion: division with rest " + quotRemd[1] + " for " + sum.negate() + " / " + pvals[mOrder + 1]); }
            result = null; // end of sequence
          } else {
            result = quotRemd[0];
          }
        } else {
          /**/ if (sDebug >= 1) { System.out.println("assertion: division by zero "); }
          result = null; // end of sequence
        }
      }
    }

    if (mExponentialType) { // exponential: multiply buffer by mN
      final Z zn = Z.valueOf(mN);
      for (int ire = 0; ire < mRElen; ++ire) {
        /**/ if (sDebug >= 1) { System.out.println("  exp: multiply ring=" + showRE() + " by mN=" + mN); }
        mRElems[ire] = mRElems[ire].multiply(zn);
      }
    }
    setRE(result);

    /**/ if (sDebug >= 1) { System.out.println("result=" + result + ", RE=" + showRE()); }
    return result;
  } // next

  /**
   * For <code>gftype=ADJUNCT</code>, add the value of some function of the current index {@link #mN}.
   * to the constant term in the recurrence equation.
   * This method is typically overwritten, for example in {@link ComplementaryEquationSequence}.
   * @param n index of the term a(n) to be computed
   * @return value to be added to the constant term (default: 0).
   */
  public Z adjunct(final int n) {
    return Z.ZERO;
  }

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
   */
  public int getOrder() {
    return mOrder;
  }

  /**
   * Gets the vectors for the coefficient polynomials.
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
    return mShift;
  }

  /**
   * When the elements are interpreted as coefficients of a Polynomial in <code>n</code>
   * (where the vector indices <code>k = 0, 1, 2</code> and so on are the exponents of <code>n</code>),
   * then the result has the coeffients after the mapping <code>x</code> to <code>n + dist</code>.
   * @param vector the Z array to be shifted
   * @param shift map n -&gt; n + shift (may be negative)
   * @return a new, shifted Z array
   */
  private static Z[] shiftRow(final Z[] vector, final int shift) {
    final Z zShift = Z.valueOf(shift);
    final int len = vector.length;
    final Z[] result = new Z[len];
    final Z[] dipows = new Z[len]; // powers of shift
    final Z[] binoms = new Z[len]; // a row of Pascal's triangle
    for (int irow = 0; irow < len; ++irow) {
      if (irow == 0) {
        dipows[0] = Z.ONE;
      } else {
        dipows[irow] = dipows[irow - 1].multiply(zShift);
      }
      binoms[irow] = Z.ONE;
    } // for irow
    for (int irow = 0; irow < len; ++irow) {
      if (irow > 0) {
        for (int icol = 1; icol < len; ++icol) {
          binoms[icol] = binoms[icol - 1].add(binoms[icol]);
        } // for icol
      }
      Z sum = Z.ZERO;
      for (int icol = irow; icol < len; ++icol) {
        sum = sum.add(vector[icol].multiply(dipows[icol - irow]).multiply(binoms[icol - irow]));
      } // for icol
      result[irow] = sum;
    } // for irow
    return result;
  } // shiftRow

  /**
   * Modifies the recurrence such that the shift (distance) becomes zero.
   */
  public void unshift() {
    if (mShift != 0) {
      for (int irow = mPolyList.size() - 1; irow >= 0; --irow) {
        mPolyList.set(irow, shiftRow(mPolyList.get(irow), - mShift));
      }
      mShift = 0;
    }
  } // unshift

  /**
   * Modifies the recurrence such that the last element
   * (the coefficient of the highest power of n in the polynomial for a(n)) has a defined sign.
   * @param sign +1 or -1, the desired sign
   */
  public void normalizeSign(int sign) {
    Z[] row = mPolyList.get(mPolyList.size() - 1);
    if (row[row.length - 1].signum() != sign) {
      for (int irow = mPolyList.size() - 1; irow >= 0; --irow) {
        row = mPolyList.get(irow);
        for (int icol = row.length - 1; icol >= 0; --icol) {
          row[icol] = row[icol].negate();
        }
        // no 'set(irow)' because 'row' is a pointer
      }
    }
  } // normalizeSign

  /**
   * Removes the shift and normalizes the sign.
   */
  public void normalize() {
    unshift();
    normalizeSign(1);
  } // normalize

  /**
   * Gets a String representation
   * of the coefficient polynomials.
   * @return a list of polynomials of the form "[[0,1],[1,2],[1]]".
   */
  public String getPolyString() {
    final StringBuilder result = new StringBuilder(256);
    final ArrayList<Z[]> polyList = getPolyList();
    for (int i = 0; i < polyList.size(); ++i) { // polynomials
      final Z[] poly = polyList.get(i);
      result.append(i == 0 ? '[' : ',');
      for (int j = 0; j < poly.length; ++j) {
        result.append(j == 0 ? '[' : ',');
        result.append(poly[j]);
      } // for j
      result.append(']');
    } // for i
    result.append(']');
    return result.toString();
  } // getPolyString

  /**
   * Gets a String representation
   * of the initial terms.
   * @return a list of terms of the form "[0,1,1,2,1]".
   */
  public String getInitString() {
    final StringBuilder result = new StringBuilder(256);
    final Z[] initTerms = getInitTerms();
    int j = 0;
    while (j < initTerms.length) {
      result.append(j == 0 ? '[' : ',');
      result.append(initTerms[j]);
      ++j;
    } // while j
    result.append(']');
    return result.toString();
  } // getInitString()

} // HolonomicRecurrence
