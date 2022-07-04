package irvine.oeis.a261;

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A261301 a(n+1) = abs(a(n) - gcd(a(n), 1*n + 0)), a(1) = 1.
 * @author Georg Fischer
 */
public class A261301 implements Sequence {

  private int mN;
  private int mMult;
  private Z mA;

  /** Construct the sequence. */
  public A261301() {
    this(1);
  }

  /**
   * Generic constructor with parameters
   * @param mult multiplier
   */
  public A261301(final int mult) {
    mN = 0;
    mMult = mult;
    mA = Z.ONE;
  }

  @Override
  public Z next() {
    if (++mN > 1) {
      mA = mA.subtract(mA.gcd(Z.valueOf((mN - 1) * mMult + mMult - 1))).abs();
    }
    return mA;
  }
}
