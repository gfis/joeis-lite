package irvine.oeis.a107;

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.a000.A000040;

/**
 * A107689 Primes with digital product = 3.
 * @author Georg Fischer
 */
public class A107689 extends A000040 {

  private Z mDigitProd;

  /** Construct the sequence. */
  public A107689() {
    this(3);
  }

  /**
   * Generic constructor with parameter
   * @param digitProd desired product of the digits 
   */
  public A107689(final int digitProd) {
    mDigitProd = Z.valueOf(digitProd);
  }

  @Override
  public Z next() {
    Z prime = super.next();
    while (!ZUtils.digitProduct(prime).equals(mDigitProd)) {
      prime = super.next();
    }
    return prime;
  }
}
