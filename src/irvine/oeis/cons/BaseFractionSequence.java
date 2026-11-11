package irvine.oeis.cons;

import irvine.math.cr.CR;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * Sequence formed by the base-n expansion of a quotient of two integers.
 * @author Georg Fischer
 */
public class BaseFractionSequence extends DecimalExpansionSequence {

  private final int mBase; // number base for the expansion, between 2 and 10
  private final Z mNum; // numerator, must be positive
  private final Z mDen; // denominator, must be positive
  private Z mCurNum; // current numerator
  private Z mCurDen; // current denominator
  private Z mQ; // quotient reached so far
  protected int mN; // current index

  /**
   * Construct a new expansion of a computable real number.
   * @param offset first index
   * @param num numerator of the fraction
   * @param den denominator of the fraction
   * @param base base for expansion
   */
  public BaseFractionSequence(final int offset, final Z num, final Z den, final int base) {
    super(offset, CR.valueOf(num).divide(den));
    mBase = base;
    mNum = num;
    mDen = den;
    mN = offset - 1;
    mCurNum = mNum;
    mCurDen = mDen;
    while (mCurNum.compareTo(mCurDen) > 0) {
      mCurDen = mCurDen.multiply(mBase);
    }
    next();
  }

  @Override
  public Z next() {
    final Z[] q = mCurNum.divideAndRemainder(mCurDen);
    mCurNum = q[1].multiply(mBase);
    return q[0];
  }

  /**
   * Get the number base.
   * @return the base
   */
  public int getBase() {
    return mBase;
  }

  /**
   * Get the fraction in lowest terms.
   * @return the underlying quotient
   */
  public Q getFraction() {
    return new Q(mNum, mDen);
  }

}
