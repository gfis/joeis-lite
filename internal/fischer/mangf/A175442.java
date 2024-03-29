package irvine.oeis.a175;

import irvine.factor.prime.Fast;
import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A175442 a(n)&gt;a(n-1), a(n) = smallest prime such that a(n)+a(n-1) is multiple of m, a(1)=2, m=3.
 * @author Georg Fischer
 */
public class A175442 implements Sequence {

  private int mN;
  private Z mM;
  private Z mA; // a(n)
  private Z mP; // prime
  private final Fast mPrime = new Fast();

  /** Construct the sequence. */
  public A175442() {
    this(2, 3);
  }

  /**
   * Generic constructor with parameters
   * @param start value of a(1)
   * @param m multiple
   */
  public A175442(final int start, final int m) {
    mN = 0;
    mM = Z.valueOf(m);
    mA = Z.valueOf(start);
  }

  @Override
  public Z next() {
    if (++mN == 1) {
      return mA;
    }
    Z a1 = mA;
    while (true) {
      mA = mPrime.nextPrime(mA); // next candidate
      if (a1.add(mA).mod(mM).isZero()) {
        return mA;
      }
    }
  }
}
