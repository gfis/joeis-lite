package irvine.oeis.a176;
// Generated by gen_seq4.pl trisumm/trisimple at 2023-06-09 19:35

import irvine.math.z.Fibonacci;
import irvine.math.z.Z;
import irvine.oeis.triangle.BaseTriangle;

/**
 * A176046 Triangle T(n,m) = 1 + F(m) + F(n-m) - F(n), read by rows, where F = A000045 is the Fibonacci sequence.
 * @author Georg Fischer
 */
public class A176046 extends BaseTriangle {

  /** Construct the sequence. */
  public A176046() {
    super(0, 0, 0);
    hasRAM(true);
  }
  
  @Override
  public Z triangleElement(final int n, final int k) {
    return Z.ONE.add(Fibonacci.fibonacci(k)).add(Fibonacci.fibonacci(n - k)).subtract(Fibonacci.fibonacci(n));
  }
}