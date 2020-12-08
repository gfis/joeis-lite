package irvine.oeis.a046;
// manually, 2020-12-08

import irvine.math.z.Z;
import irvine.oeis.GeneralizedEulerTransform;
import irvine.oeis.a000.A000583; // fourth powers

/**
 * A046042 Number of partitions of n into fourth powers.
 * G.f.: -1 + 1/product(1-x^(k^4), k > 0).
 * @author Georg Fischer
 */
public class A046042 extends GeneralizedEulerTransform {

  /** Construct the sequence. */
  public A046042() {
    super(new long[0]);
    mSeqH = new A000583();
    advanceH(0); // skip A000583(0)
    mHp1 = advanceH(1);
  }

  @Override
  protected int advanceH(final int k) {
    return mSeqH.next().intValue();
  }

}
