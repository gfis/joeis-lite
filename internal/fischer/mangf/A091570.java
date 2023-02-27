package irvine.oeis.a091;

import irvine.math.z.Z;
import irvine.math.z.Integers;
import irvine.oeis.Sequence1;

/**
 * A091570 Sum of odd proper divisors of n. Sum of the odd divisors of n that are less than n.
 * @author Georg Fischer
 */
public class A091570 extends Sequence1 {

  private int mN;
  private int mExpon;

  /** Construct the sequence. */
  public A091570() {
    this(1);
  }

  /**
   * Generic constructor with parameters
   * @param expon exponent for the sum
   */
  public A091570(final int expon) {
    mN = 0;
    mExpon = expon;
  }

  @Override
  public Z next() {
    ++mN;
    return Integers.SINGLETON.sumdiv(mN, d -> ((d & 1) == 1 && d != mN) ? Z.valueOf(d).pow(mExpon) : Z.ZERO);
  }
}
