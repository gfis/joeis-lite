package irvine.oeis.a143;
// Generated by gen_seq4.pl trisumm/trisimple at 2023-06-09 19:35

import irvine.math.z.Z;
import irvine.oeis.triangle.BaseTriangle;

/**
 * A143198 Triangle t(n,m) = n +(n+1)*(m-1)*(m+2)/2 read by rows, 0&lt;=m&lt;=n.
 * @author Georg Fischer
 */
public class A143198 extends BaseTriangle {

  /** Construct the sequence. */
  public A143198() {
    super(0, 0, 0);
    hasRAM(true);
  }
  
  @Override
  public Z triangleElement(final int n, final int k) {
    return Z.valueOf(n + 1).multiply(k - 1).multiply(k + 2).divide2().add(n);
  }
}