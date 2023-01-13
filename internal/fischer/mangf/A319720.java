package irvine.oeis.a319;

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.Sequence0;

/**
 * A319652 Write n in 4-ary, sort digits into increasing order.
 * @author Georg Fischer
 */
public class A319720 extends Sequence0 {

  private long mN;
  private int mBase;

  /** Construct the sequence. */
  public A319720() {
    this(4);
  }

  /**
   * Generic constructor with parameters
   * @param base number b ase
   */
  public A319720(final int base) {
    mN = -1;
    mBase = base;
  }

  public Z next() {
    return ZUtils.sortDigitsDescending(Z.valueOf(++mN), mBase);
  }
}
