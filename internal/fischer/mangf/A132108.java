package irvine.oeis.a132;
// Generated by gen_seq4.pl trisumm/trisimple at 2023-06-07 21:43

import irvine.math.z.Binomial;
import irvine.math.z.Z;
import irvine.oeis.triangle.BaseTriangle;

/**
 * A132108 Triangle T(n,k) = binomial(n,k)+n-k read by rows.
 * @author Georg Fischer
 */
public class A132108 extends BaseTriangle {

  /** Construct the sequence. */
  public A132108() {
    super(0, 0, 0);
    hasRAM(true);
  }
  
  @Override
  public Z triangleElement(final int n, final int k) {
    return Binomial.binomial(n,k).add(n - k);
  }
}
