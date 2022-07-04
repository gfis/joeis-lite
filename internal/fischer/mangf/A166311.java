package irvine.oeis.a166;

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.Sequence;

/**
 * A166311 Numbers whose sum of digits is 11.
 * @author Georg Fischer
 */
public class A166311 implements Sequence {

  private Z mN;
  private int mSum;

  /** Construct the sequence. */
  public A166311() {
    this(11);
  }

  /**
   * Generic constructor with parameters
   * @param sum desired sum of digits
   */
  public A166311(final int sum) {
    mN = Z.ZERO;
    mSum = sum;
  }

  @Override
  public Z next() {
    while (true) {
      mN = mN.add(1);
      if (ZUtils.digitSum(mN) == mSum) {
        return mN;
      }
    }
  }
}
