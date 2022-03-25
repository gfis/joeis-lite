package irvine.oeis.a089;

import irvine.math.z.Z;
import irvine.oeis.a000.A000040;

/**
 * A089347 Primes of the form identical digits followed by a 1.
 * @author Georg Fischer
 */
public class A089347 extends A000040 {

  protected int mLast;

  /** Construct the sequence. */
  public A089347() {
    this(1);
  }

  /**
   * Generic constructor with parameter
   * @param last last character
   */
  public A089347(final int last) {
    mLast = last;
  }
  
  @Override
  public Z next() {
    while (true) {
      final Z prime = super.next();
      final String sp = prime.toString();
      final int splm1 = sp.length() - 1;
      if (sp.charAt(splm1) - '0' == mLast) {
        if (splm1 >= 1) {
          final char sp0 = sp.charAt(0);
          if (sp.substring(0, splm1).matches(sp0 + "+")) {
            return prime;
          }
        } else {
          return prime;
        }
      }
    }
  }
}
