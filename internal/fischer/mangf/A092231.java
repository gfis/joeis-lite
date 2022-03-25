package irvine.oeis.a092;

import irvine.math.z.Z;
import irvine.oeis.a092.A092221;

/**
 * A092231 Numbers k such that numerator of Bernoulli(2*k) is divisible by 37 and 59, the first two irregular primes.
 * @author Georg Fischer
 */
public class A092231 extends A092221 {

  private Z m59 = Z.valueOf(59);
  
  /** Construct the sequence. */
  public A092231() {
    super(37);
  }

  /**
   * Test the condition.
   * @param n current index
   * @return true if the condition is met, or false otherwise.
   */
  protected boolean isOk(final long n) {
    mBern.nextQ();
    final Z bnum = mBern.nextQ().num();
    return bnum.divideAndRemainder(mDiv)[1].isZero()
        && bnum.divideAndRemainder(m59)[1].isZero();
  }

}
