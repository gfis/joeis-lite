package irvine.oeis.a143;
// Generated by gen_seq4.pl trisumm/trisimple at 2023-06-09 19:35

import irvine.math.z.Z;
import irvine.oeis.triangle.BaseTriangle;

/**
 * A143802 Triangle read by rows, &quot;n&quot; followed by (n-1) terms of (1, 3, 7, 15, ...).
 * @author Georg Fischer
 */
public class A143802 extends BaseTriangle {

  /** Construct the sequence. */
  public A143802() {
    super(1, 1, 1);
    hasRAM(true);
  }
  
  @Override
  public Z triangleElement(final int n, final int k) {
    return (k == 1) ? Z.valueOf(n) : Z.ONE.shiftLeft(k - 1).subtract(1);
  }
}
