package irvine.oeis;

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import java.util.ArrayList;
/**
 * Properties of a (simple) periodic continued fraction
 * for the square root of a number,
 * its numerators, denominators and period elements.
 * This class is used for the continued fraction
 * of a single square root, and for the property sequences for
 * the continued fractions of all square roots.
 * @author Georg Fischer
 */
public class ContinuedFractionOfSqrtSequence implements Sequence {

  protected int mN; // index of current term to be returned
  protected int mK; // compute the sqrt of this number
  protected boolean mIsPow2; // whether mK is a square
  protected int mRoot; // the integer root, floor(sqrt(n))
  protected int mB0; // numerator   of old partial fraction
  protected int mB1; // denominator of new partial fraction
  protected Z   mC0; // old convergent numerator
  protected Z   mC1; // new convergent numerator
  protected Z   mD0; // old convergent denominator
  protected Z   mD1; // new convergent denominator
  protected int mP0; // numerator   of old partial fraction
  protected int mP1; // denominator of new partial fraction
  protected int mQ0; // numominator of old partial fraction
  protected int mQ1; // denominator of new partial fraction
  protected int mPerInd; // index  in period
  protected int mPerLen; // length of period
  protected int mPerCent; // element in the middle of the period
  protected int mPerMin; // least element of the period
  protected int mPerCount1; // number of ONEs in the period
  protected int [] mPeriod;

  /**
   * Construct an instance which selects all numbers
   * that have some property in the continued fractions
   * of their square roots.
   * @param offset first valid term has this index
   */
  protected ContinuedFractionOfSqrtSequence(final int offset) {
    mN = offset;
    mK = offset - 1; // will be increased in first call of getNext(With)Property
  }

  /**
   * Construct the continued fraction for the square root
   * of a single, specified number.
   * @param offset first valid term has this index
   * @param k compute the sqrt of this non-negative number
   */
  protected ContinuedFractionOfSqrtSequence(final int offset, final int k) {
    mN  = offset;
    mK  = k;
    initialize();
    mPeriod = new int[8192];
    mC0     = Z.ONE;
    mD0     = Z.ZERO;
    mC1     = Z.valueOf(mRoot);
    mD1     = Z.ONE;
  }

  /**
   * Initialize the member properties.
   * The caller must already have set <em>mK, mN</em>.
   * This method is used for the continued fraction
   * of a single square root, and for the property sequences for
   * the continued fractions of all square roots.
   */
  protected void initialize() {
    mRoot   = (int) Math.floor(Math.sqrt(mK));
    mIsPow2 = mRoot * mRoot == mK;
    mPeriod = new int[mRoot + 4];
    mP0     = 0;
    mQ0     = 1;
    mB0     = mRoot;
    mP1     = 0;
    mQ1     = 0;
    mB1     = 1;
    mPerLen = -1; // undefined so far
    mPerInd = 0; // index in mPeriod
  } // initialize

  /**
   * Initialize the member properties, and fill the period.
   * The caller must already have set <em>mK, mN</em>.
   * This method is used for the selection of some
   * property of the continued fractions of the square roots
   * of all numbers.
   */
  protected void fillPeriod() {
    initialize();
    mPerCount1 = 0;
    if (! mIsPow2) { // no square number
      while (mPerLen < 0 || mPerInd < mPerLen) { // fill
        mN ++;
        mP1 = mB0 * mQ0 - mP0;
        mQ1 = (mK - mP1 * mP1) / mQ0;
        mB1 = (mRoot + mP1) / mQ1;
        if (mPerLen < 0) {
          if (mQ0 == mQ1) {
            mPerLen = mPerInd * 2 + 1;
            mPerCent = mB0;
          } else if (mP0 == mP1) {
            mPerLen = mPerInd * 2;
            mPerCent = mB0;
          }
        }
        if (mPerInd == 0) { // first period element
          mPerMin = mB1;
        } else if (mB1 < mPerMin) {
          mPerMin = mB1;
        }
        if (mB1 == 1) {
          mPerCount1 ++;
        }
        mPerInd ++;
        mP0 = mP1;
        mQ0 = mQ1;
        mB0 = mB1;
      } // while filling
    } else {
      mPerLen = 0;
      mPerInd = 0;
      mPerMin = 0;
    }
  } // fillPeriod

  /**
   * Compute the elements for the next partial fraction.
   * This method must be called <em>after</em> fetching any
   * sequence element from the member properties.
   */
  protected void iterate() {
    mN ++;
    if (! mIsPow2) { // no square number
      mP1 = mB0 * mQ0 - mP0;
      mQ1 = (mK - mP1 * mP1) / mQ0;
      mB1 = (mRoot + mP1) / mQ1;
      if (mPerLen < 0) {
        if (mQ0 == mQ1) {
          mPerLen = mPerInd * 2 + 1;
        }
        else
        if (mP0 == mP1) {
          mPerLen = mPerInd * 2;
        }
      }
      mPerInd ++;
      mP0 = mP1;
      mQ0 = mQ1;
      mB0 = mB1;
      if (mPerLen < 0 || mPerInd <= mPerLen) {
        mPeriod[mPerInd] = mB1;
      }
      final Z mC2 = Z.valueOf(mB1).multiply(mC1).add(mC0);
      mC0 = mC1;
      mC1 = mC2;
      final Z mD2 = Z.valueOf(mB1).multiply(mD1).add(mD0);
      mD0 = mD1;
      mD1 = mD2;
    } else {
      mB0 = 0;
      mPerLen = 0;
    } // no square number
  } // iterate

  /**
   * Determine whether the period is completely filled
   * @return true iff filled
   */
  public boolean hasFilledPeriod() {
    return mPerLen >= 0 && mPerInd >= mPerLen;
  } // hasFilledPeriod

  /**
   * Determine whether the period has a specified length.
   * The caller must already have filled the period.
   * @param len desired length of the period
   * @return true iff the period has this length
   */
  public boolean hasPeriodLength(int len) {
    return mPerLen == len;
  } // hasFilledPeriod

  /**
   * Determine whether the period has a length of some parity
   * and a specified central element.
   * The caller must already have filled the period.
   * @param element desired element of the period
   * @param parity parity of the period length: 0 = even, 1 = odd
   * @return true iff the period has this element
   */
  public boolean hasPeriodCentral(int parity, long element) {
    return (mPerLen & 1) == parity && mPeriod[mPerLen >> 1] == element;
  } // hasPeriodCentral

  /**
   * Gets the count of some value in the period
   * The caller must already have filled the period,
   * and it must hava a length >= 1 (no perfect square).
   * @param value the desired value to be counted
   * @return the least element
   */
  public int getCountInPeriod(int value) {
    int iper = mPerLen - 1;
    int result = 0;
    while (iper >= 0) {
      if (mPeriod[iper] == value) {
        result ++;
      }
      iper --;
    } // while iper
    return result;
  } // getCountInPeriod

  /**
   * Gets the least element in the period
   * The caller must already have filled the period,
   * and it must hava a length >= 1 (no perfect square).
   * @return the least element
   */
  public Z getMinInPeriod() {
    int iper = mPerLen - 1;
    int min = mPeriod[0];
    while (iper > 0) {
      int element = mPeriod[iper];
      if (element < min) {
        min = element;
      }
      iper --;
    } // while iper
    return Z.valueOf(min);
  } // getMinInPeriod

  //=====================================
  /**
   * Get the next term of the sequence.
   * This is an example only.
   * The method is typically overwritten to get some other
   * element related to the continued fraction of the square root
   * of this number.
   * @return the next element of the continued fraction
   */
  @Override
  public Z next() {
    Z result = Z.valueOf(mB0); // member of the periodic continued fraction
    iterate();
    return result;
  } // next

  /**
   * Get some property of the period of the continued fraction for sqrt(n).
   * @return property of the next number
   */
  protected Z getNextProperty() {
    mK ++;
    fillPeriod();
    return getProperty();
  } // getNextProperty

  /**
   * Get the next term of a sequence which fulfills some property
   * of the period of the continued fraction for the square root of the term.
   * @return the next number with the property
   */
  protected Z getNextWithProperty() {
    int loopCheck = 1000000;
    while (loopCheck > 0) {
      mK ++;
      fillPeriod();
      if (isOk()) {
        loopCheck = -1;
      }
      loopCheck --;
    } // while busy
    if (loopCheck == 0) {
      System.err.println("more the 1 million iterations in ContinuedFractionOfSqrtSequence.getNextWithProperty()");
    }
    return Z.valueOf(mK);
  } // getNextWithProperty

  /**
   * Get the size of the period of the continued fraction for sqrt(n).
   * This method is an example only.
   * It is typically overwritten in order to return some other property.
   * The caller must ensure that the period is already filled.
   * @return property of the period of the continued fraction for the square root
   * of the current number <em>mK</em>.
   */
  protected Z getProperty() {
    return Z.valueOf(mPerLen);
  } // getProperty

  /**
   * Determine whether the period of the continued fraction for sqrt(n)
   * has an even length.
   * This method is an example only.
   * It is typically overwritten in order to return some other property.
   * The caller must ensure that the period is already filled.
   * @return true iff the continued fraction for the square root
   * of the current number <em>mK</em> has some property.
   */
  protected boolean isOk() {
    return (mPerLen & 1) == 0;
  } // isOk

  /**
   * Determine whether the least term in the period has the specified value.
   * The caller must ensure that the period is already filled.
   * @param least the desired least period element value
   * @return true iff the period of the continued fraction for the square root
   * of the current number <em>mK</em> has this property.
   */
  protected boolean isMinInPeriod(int min) {
    return mPerLen > 0 && Z.valueOf(min).equals(getMinInPeriod());
  } // isLeastInPeriod

  /**
   * Get the index of the current term of the sequence.
   * @return the index starting with the offset of the sequence
   */
  protected int getIndex() {
    return mN;
  } // getIndex

  /**
   * Get the index of the current term of the sequence.
   * @return the index starting with the offset of the sequence
   */
  protected int size() {
    return mPerLen;
  } // size

  /**
   * Get the next term of the sequence.
   * @return numerator of the convergent
   */
  protected Z getNumerator() {
    return mC1;
  } // getNumerator

  /**
   * Get the next term of the sequence.
   * @return denominator of the convergent
   */
  protected Z getDenominator() {
    return mD1;
  } // getDenominator

  //=====================================
  /** Test method.
   *  @param args command line arguments: [n [noterms]]
   *  Show various elements related to the continued fraction for the square root of n.
   *  If n is &lt; 0, several properties of the period for all numbers are shown.
   */
  public static void main(String[] args) {
    int n = -1;
    int iarg = 0;
    if (iarg < args.length) {
      try {
        n = Integer.parseInt(args[iarg ++]);
      } catch (Exception exc) {
      }
    }
    int noterms = 16;
    if (iarg < args.length) {
      try {
        noterms = Integer.parseInt(args[iarg ++]);
      } catch (Exception exc) {
      }
    }
    ContinuedFractionOfSqrtSequence cf = null;
    int iterm = 0;
    if (n >= 0) { // properties of a single nubmer
      cf = new ContinuedFractionOfSqrtSequence(1, n);
      while (iterm < noterms) {
        System.out.print(iterm
           + ":\tB0=" + cf.mB0
           +  ", B1=" + cf.mB1
           +  ", P0=" + cf.mP0
           +  ", P1=" + cf.mP1
           +  ", Q0=" + cf.mQ0
           +  ", Q1=" + cf.mQ1
           +  ", C0=" + cf.mC0
           +  ", C1=" + cf.mC1
           +  ", D0=" + cf.mD0
           +  ", D1=" + cf.mD1
           + ",\tPerLen=" + cf.mPerLen
           +  ", PerInd=" + cf.mPerInd
           + "\t"     + cf.mC0 + "/" + cf.mD0
           );
        System.out.println("\t-> "  + cf.next().toString());
        iterm ++;
      } // while iterm
      System.out.println(cf.mPeriod + " length=" + cf.mPerLen);
    } else { // properties of all numbers
      cf = new ContinuedFractionOfSqrtSequence(1); // always offset 1 ?!
      while (iterm < noterms) {
        Z prop = cf.getNextProperty();
        System.out.println(cf.mK
            + ":\tsize="  + prop
            + ", period=" + cf.mPeriod
            + ", even="   + cf.isOk()
            );
        iterm ++;
      } // while iterm
    } // all
  } // main

} // ContinuedFractionOfSqrtSequence
