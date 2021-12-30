package irvine.oeis.a090;

import irvine.math.z.Z;
import irvine.oeis.a000.A000040;

/**
 * A090149 Primes of the form identical digits preceded by a 1.
 * @author Georg Fischer
 */
public class A090149 extends A000040 {

  protected int mFirst;

  /** Construct the sequence. */
  public A090149() {
    this(1);
  }

  /**
   * Generic constructor with parameter
   * @param first first character
   */
  public A090149(final int first) {
    mFirst = first;
  }
  
  @Override
  public Z next() {
    while (true) {
      final Z prime = super.next();
      final String sp = prime.toString();
      if (sp.charAt(0) - '0' == mFirst) {
        if (sp.length() >= 2) {
          final char sp1 = sp.charAt(1);
          if (sp.substring(1).matches(sp1 + "+")) {
            return prime;
          }
        } else {
          return prime;
        }
      }
    }
  }
}
