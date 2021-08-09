package irvine.oeis.a206;
// manually, 2020-12-08

import irvine.math.z.Z;
import irvine.oeis.GeneralizedEulerTransform;
import irvine.oeis.a002.A002275;

/**
 * A206244 Number of partitions of n into repunits (A002275).
 * @author Georg Fischer
 */
public class A206244 extends GeneralizedEulerTransform {

  /** Construct the sequence. */
  public A206244() {
    super();
    mSeqH = new A002275();
    advanceH(0); // skip A002275(0)
    mHp1 = advanceH(1);
  }

  @Override
  protected long advanceH(final long k) {
    return mSeqH.next().longValue();
  }

}
