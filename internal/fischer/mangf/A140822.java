package irvine.oeis.a140;
// Generated by gen_seq4.pl trisumm/trisimple at 2023-06-07 21:43

import irvine.math.IntegerUtils;
import irvine.math.z.Binomial;
import irvine.math.z.Z;
import irvine.oeis.triangle.BaseTriangle;

/**
 * A140822 Triangle T(n,m) = binomial(n,gcd(n,m)) read by rows, 0&lt;=m&lt;=n.
 * @author Georg Fischer
 */
public class A140822 extends BaseTriangle {

  /** Construct the sequence. */
  public A140822() {
    super(0, 0, 0);
    hasRAM(true);
  }
  
  @Override
  public Z triangleElement(final int n, final int k) {
    return Binomial.binomial(n,IntegerUtils.gcd(n,k));
  }
}