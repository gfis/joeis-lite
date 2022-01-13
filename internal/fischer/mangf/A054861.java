package irvine.oeis.a054;

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.Sequence;

/**
 * A054861 Highest power of 3 dividing n!.
 * @author Georg Fischer
 */
public class A054861 implements Sequence {
  
  protected long mN;
  protected long mBase;
  protected Z result;

  /** Construct the sequence. */
  public A054861() {
    this(3);
  }

  /**
   * Generic constructor with parameters
   * @param base take the power of this parameter
   */
  public A054861(final int base) {
    mBase = base;
    mN  = -1;
    result = Z.ZERO;
  }

  public static int ord(final Z a, Z b) {
    int d = 0;
    Z[] qr;
    while ((qr = b.divideAndRemainder(a))[1].isZero() && !b.isZero()) {
      ++d;
      b = qr[0];
    }
    return d;
  }

  @Override
  public Z next() {
    ++mN;
    if (mN % mBase == 0) {
      result = result.add(this.ord(Z.valueOf(mBase), Z.valueOf(mN)));
    }
    return result;
  }
}
