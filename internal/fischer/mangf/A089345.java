package irvine.oeis.a089;

import irvine.math.z.Z;
import irvine.oeis.a000.A000040;

/**
 * A089345 Primes of the form identical even digits followed by a 1.
 * @author Georg Fischer
 */
public class A089345 extends A000040 {

  protected int mParity;

  /** Construct the sequence. */
  public A089345() {
    this(0);
  }

  /**
   * Generic constructor with parameter
   * @param parity 0 = even digits, 1 = odd digits
   */
  public A089345(final int parity) {
    mParity = parity;
  }
  
  @Override
  public Z next() {
    while (true) {
      final Z prime = super.next();
      final String sp = prime.toString();
      final int splm1 = sp.length() - 1;
      if (splm1 >= 1) {
        final char sp0 = sp.charAt(0);
        if ((sp0 & 1) == mParity && sp.charAt(splm1) == '1') {
          if (sp.substring(0, splm1).matches("[" + sp0 + "]+")) {
            return prime;
          }
        }
      }
    }
  }
}
