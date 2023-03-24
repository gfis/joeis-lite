package irvine.oeis.a068;

import irvine.math.z.Z;
import irvine.math.z.ZUtils; 
import irvine.oeis.AbstractSequence;

/**
 * A068127 Triangular numbers with sum of digits = 3.
 * @author Georg Fischer
 */
public class A068127 extends AbstractSequence {

  private long mN;
  private int mSum;

  /** Construct the sequence. */
  public A068127() {
    this(1, 3);
  }

  /**
   * Generic constructor with parameters
   * @param offset first index
   * @param sum required sum of digits
   */
  public A068127(final int offset, final int sum) {
    super(offset);
    mN = offset - 1;
    mSum = sum;
  }

  @Override
  public Z next() {
    while (true) {
      ++mN;
      final Z result = Z.valueOf(mN).multiply(mN - 1).divide(2);
      if (ZUtils.digitSum(result) == mSum) {
        return result;
      }
    }
  }
}
