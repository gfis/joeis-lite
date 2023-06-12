package irvine.oeis.a104;
// Generated by gen_seq4.pl trisumm/trisimple at 2023-06-09 19:35

import irvine.math.z.Z;
import irvine.oeis.triangle.BaseTriangle;

/**
 * A104727 Triangle T(n,k) = (k-1-n)*(k-2-n)*(k^2+k+2*k*n+3*n^2+5*n)/24 read by rows, 1&lt;=k&lt;=n.
 * @author Georg Fischer
 */
public class A104727 extends BaseTriangle {

  /** Construct the sequence. */
  public A104727() {
    super(1, 1, 1);
    hasRAM(true);
  }
  
  @Override
  public Z triangleElement(final int n, final int k) {
    return Z.valueOf((k - 1 - n)*(k - 2 - n)*(k*k + k + 2*k*n + 3*n*n + 5*n)/24);
  }
}
