package irvine.oeis.a158;
// Generated by gen_seq4.pl trisumm/trisimple at 2023-06-09 19:35

import irvine.math.z.Fibonacci;
import irvine.math.z.Z;
import irvine.oeis.triangle.BaseTriangle;

/**
 * A158753 Triangle T(n, k) = A000032(2*(n-k) + 1), read by rows.
 * @author Georg Fischer
 */
public class A158753 extends BaseTriangle {

  /** Construct the sequence. */
  public A158753() {
    super(2, 2, 2);
    hasRAM(true);
  }
  
  @Override
  public Z triangleElement(final int n, final int k) {
    return Fibonacci.lucas(2*(n - k) + 1);
  }
}