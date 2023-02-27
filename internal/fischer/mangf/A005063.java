package irvine.oeis.a005;

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.Sequence1;

/**
 * A005063 Sum of squares of primes dividing n.
 * @author Sean A. Irvine
 */
public class A005063 extends Sequence1 {

  private long mN = 0;
  private int mExpon;

  /** Construct the sequence. */
  public A005063() {
    this(2);
  }

  /**
   * Generic constructor with parameters
   * @param expon exponent for the sum
   */
  public A005063(final int expon) {
    mExpon = expon;
  }

  @Override
  public Z next() {
    Z s = Z.ZERO;
    for (final Z p : Jaguar.factor(++mN).toZArray()) {
      if (!Z.ONE.equals(p)) {
        s = s.add(p.pow(mExpon));
      }
    }
    return s;
  }
}
