package irvine.oeis.a352;

import irvine.math.q.Rationals;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.oeis.Sequence1;

/**
 * A352047 Sum of the divisor complements of the odd proper divisors of n.
 * @author Georg Fischer
 */
public class A352047 extends Sequence1 {

  private int mN;
  private int mExpon;

  /** Construct the sequence. */
  public A352047() {
    this(1);
  }

  /**
   * Generic constructor with parameters
   * @param expon exponent for the sum
   */
  public A352047(final int expon) {
    mN = 0;
    mExpon = expon;
  }

  @Override
  public Z next() {
    ++mN;
    return Rationals.SINGLETON.sumdiv(mN, d -> ((d & 1) == 1 && d != mN) 
        ? new Q(Z.ONE, Z.valueOf(d).pow(mExpon)) : Q.ZERO)
        .multiply(Z.valueOf(mN).pow(mExpon)).num();
  }
}
