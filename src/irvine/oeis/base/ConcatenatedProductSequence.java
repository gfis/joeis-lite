package irvine.oeis.digit;

import irvine.math.z.QuadraticCongruence;
import irvine.math.z.Z;
import irvine.oeis.SequenceWithOffset;

/**
 * A sequences that enumerates numbers that are formed by the concatenation of two numbers,
 * and that are the product of two other numbers, with conditions on both pairs.
 * @author Georg Fischer
 */
public class ConcatenatedProductSequence implements SequenceWithOffset {

  private boolean mReturnConc; // true to yield base of the concatenation, false to yield base of the product
  private boolean mAdditive; // true for additive, false for multiplicative
  private int mIncr1; // add/multiply this to the first value of the concatenation.
  private int mIncr2; // add/multiply this to the second value of the concatenation.
  private int mDist; // distance of the two factors of the resulting product (0 = square).
  private Z mP; // unmodified factor of the product
  private Z mC; // unmodified component of the concatenation
  private Z mShift; // power of 10 for the shifting of the left concatenation part
  private long mLP; // unmodified factor of the product
  private long mLC; // unmodified component of the concatenation
  private long mLShift; // power of 10 for the shifting of the left concatenation part
  protected int mOffset; // first index
  private int mLevel;

  /**
   * Construct the sequence.
   * @param offset first index
   * @param mode a two-letter code for the type of operation:
   * 'c' = the result is the concatenated base number,
   * 'p' = the result is the base of the product,
   * 'a' = addititive,
   * 'm' = multiplicative.
   * @param conc1 add/multiply this to the first value of the concatenation.
   * @param conc2 add/multiply this to the second value of the concatenation.
   * @param dist distance of the two factors of the resulting product (0 = square).
   */
  public ConcatenatedProductSequence(final int offset, final String mode, final int conc1, final int conc2, final int dist) {
    mOffset = offset;
    mReturnConc = mode.indexOf('c') >= 0;
    mAdditive = mode.indexOf('a') >= 0;
    mIncr1 = conc1;
    mIncr2 = conc2;
    mDist = dist;
    mLevel = 0;
    mLP = 1;
    if (mAdditive) {
      mLC = (conc2 == 0 ? 1 : (conc2 > 0 ? 0 : - conc2));
    } else {
      mLC = 1;
    }
    mLShift = 10;
    adjustLShift();
  }

  /**
   * Ensure that {@link #mShift} is a proper shift for the left concatenation part
   */
  private void adjustShift() {
    final Z right = mAdditive ? mC.add(mIncr2) : mC.multiply(mIncr2);
    while (mShift.compareTo(right) <= 0) {
      mShift = mShift .multiply(10);
    } // now mShift > right
  }

  /**
   * Ensure that {@link #mLShift} is a proper shift for the left concatenation part
   */
  private void adjustLShift() {
    final long right = mAdditive ? mLC + mIncr2 : mLC * mIncr2;
    while (mLShift <= right) {
      mLShift *= 10;
    } // now mLShift > right
  }

  @Override
  public int getOffset() {
    return mOffset;
  }

  @Override
  public Z next() {
    switch (mLevel) {
      default:
      case 0: // start with long arithmetic
        while (mLP <= 100) {
          final long prod = mLP * (mLP + mDist);
          final long conc = mAdditive
              ? (mLC + mIncr1) * mLShift + (mLC + mIncr2)
              : (mLC * mIncr1) * mLShift + (mLC * mIncr2);
          final long comparision = conc - prod;
          // System.out.println((mAdditive ? "+ " : "* ") + "comparision=" + comparision + ", mLC=" + mLC + ", mLP=" + mLP + ", conc=" + conc + ", prod=" + prod + ", mDist=" + mDist + ", mIncr1=" + mIncr1 + ", mIncr2=" + mIncr2 + ", mLShift=" + mLShift);
          if (comparision < 0) { // advance conc
            ++mLC;
            adjustLShift();
          } else if (comparision > 0) { // advance prod
            ++mLP;
          } else {
            final Z result = Z.valueOf(mReturnConc ? mLC : mLP);
            if (mLC + mIncr1 != 0L && mLC + mIncr2 != 0) { // match found
              ++mLC;
              adjustLShift();
              ++mLP;
              return result;
            }
            ++mLC;
            adjustLShift();
            ++mLP;
          }
        }
        mLevel = 1;
        mP = Z.valueOf(mLP);
        mC = Z.valueOf(mLC);
        mShift = Z.valueOf(mLShift);
        // no(!) break - fall through
      case 1: // continue with Z arithmetic
        while (true) {
          final Z prod = mP.multiply(mP.add(mDist));
          final Z conc = mAdditive
              ? mC.add(mIncr1).multiply(mShift).add(mC.add(mIncr2))
              : mC.multiply(mIncr1).multiply(mShift).add(mC.multiply(mIncr2));
          final int comparision = conc.compareTo(prod);
          // System.out.println((mAdditive ? "+ " : "* ") + "comparision=" + comparision + ", mP=" + mP + ", conc=" + conc + ", prod=" + prod + ", mDist=" + mDist + ", mIncr1=" + mIncr1 + ", mIncr2=" + mIncr2 + ", mShift=" + mShift);
          if (comparision < 0) { // advance conc
            mC = mC.add(1);
            adjustShift();
          } else if (comparision > 0) { // advance prod
            mP = mP.add(1);
          } else { // match found
            final Z result = mReturnConc ? mC : mP;
            mC = mC.add(1);
            adjustShift();
            mP = mP.add(1);
            return result;
          }
        }
    }
  }
}
