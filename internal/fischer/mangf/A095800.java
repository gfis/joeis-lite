package irvine.oeis.a095;
// Generated by gen_seq4.pl trisumm/trisimple at 2023-06-09 19:35

import irvine.math.z.Z;
import irvine.oeis.triangle.BaseTriangle;

/**
 * A095800 Triangle T(n,k) = abs( k *( (2*n+1)*(-1)^(n+k)+2*k-1) /4 ) read by rows, 1&lt;=k&lt;=n.
 * @author Georg Fischer
 */
public class A095800 extends BaseTriangle {

  /** Construct the sequence. */
  public A095800() {
    super(1, 1, 1);
    hasRAM(true);
  }
  
  @Override
  public Z triangleElement(final int n, final int k) {
    return Z.valueOf((k * ((2*n + 1) * ((((n + k) & 1) == 0) ? 1 : -1) + 2*k - 1) / 4)).abs();
  }
}
