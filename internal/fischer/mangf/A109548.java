package irvine.oeis.a109;

import irvine.math.z.Z;
import irvine.oeis.a000.A000040;

/**
 * A109548 Primes of the form aaaa...aa1 where a is 1, 2, 3, 4 or 5.
 * @author Georg Fischer
 */
public class A109548 extends A000040 {

  protected char mLow;
  protected char mHigh;

  /** Construct the sequence. */
  public A109548() {
    this('1', '5');
  }

  /**
   * Generic constructor with parameter
   * @param low lowest digit
   * @param high highest digit
   */
  public A109548(final char low, final char high) {
    mLow = low;
    mHigh = high;
  }
  
  @Override
  public Z next() {
    while (true) {
      final Z prime = super.next();
      final String sp = prime.toString();
      final int splm1 = sp.length() - 1;
      if (sp.charAt(splm1) == '1') {
        if (splm1 >= 1) {
          final char sp0 = sp.charAt(0);
          if (sp0 >= mLow && sp0 <= mHigh && sp.substring(0, splm1).matches(sp0 + "+")) {
            return prime;
          }
        }
      }
    }
  }
}
