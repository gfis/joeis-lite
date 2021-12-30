package irvine.oeis.a113;

import irvine.math.z.Z;
import irvine.oeis.a000.A000040;

/**
 * A113628 Primes of the form 10 followed by a string of 1&apos;s.
 * @author Georg Fischer
 */
public class A113628 extends A000040 {

  protected char mLast;

  /** Construct the sequence. */
  public A113628() {
    this('1');
  }

  /**
   * Generic constructor with parameter
   * @param first first character
   */
  public A113628(final char last) {
    mLast = last;
  }
  
  @Override
  public Z next() {
    while (true) {
      final Z prime = super.next();
      final String sp = prime.toString();
      if (sp.length() >= 3) {
        if (sp.substring(0, 2).equals("10")) {
          if (sp.substring(2).matches(mLast + "+")) {
            return prime;
          }
        }
      }
    }
  }
}
