package irvine.oeis.a080;

import irvine.math.z.Z;
import irvine.oeis.Sequence0;

/**
 * A080584 A run of 3*2^n 0&apos;s followed by a run of 3*2^n 1&apos;s, for n=0, 1, 2, ...
 * @author Georg Fischer
 */
public class A080584 extends Sequence0 {

  private int mN = -1;
  private long mCount = 0;
  private Z mToggle = Z.ONE;

  @Override
  public Z next() {
    if (mCount <= 0) {
      if (mToggle.isZero()) {
        mToggle = Z.ONE;
      } else {
        mToggle = Z.ZERO;
        ++mN;
      }
      mCount = (1 << mN) * 3;
    }
    --mCount;
    return mToggle;
  }
}
