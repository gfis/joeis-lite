package irvine.oeis.a146;
// manually 

import irvine.math.z.Z;
import irvine.oeis.a000.A000110;

/**
 * A146093 Bell numbers (A000110) read mod 3.
 * @author Georg Fischer
 */
public class A146093 extends A000110 {

  protected Z mK; // mod k
  
  /** Construct the sequence. */
  public A146093() {
    this(3);
  }
  
  /**
   * Generic constructor with parameter
   * @param k apply A000110(n) mod k
   */
  public A146093(final long k) {
    mK = Z.valueOf(k);
  }
  
  @Override
  public Z next() {
    return super.next().mod(mK);
  }
}
