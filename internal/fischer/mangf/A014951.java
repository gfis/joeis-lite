package irvine.oeis.a014;

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A014951 Positive integers k such that k divides 12^k - 1.
 * @author Sean A. Irvine
 * @author Georg Fischer
 */
public class A014951 implements Sequence {

  protected int mN;
  protected int mParm1;
  protected int mParm2;
  protected Z mPow;

  /** Construct the sequence. */
  public A014951() {
    this(12, -1);
  }

  /**
   * Generic constructor with parameters: k divides parm1^k + parm2
   * @param parm1 base
   * @param parm2 additive term
   */
  public A014951(final int parm1, final int parm2) {
    mN = 0;
    mParm1 = parm1;
    mParm2 = parm2;
    mPow = Z.ONE;
  }

  @Override
  public Z next() {
    while (true) {
      ++mN;
      mPow = mPow.multiply(mParm1);
      if (mPow.add(mParm2).mod(mN) == 0) {
        return Z.valueOf(mN);
      }
    }
  }
}
