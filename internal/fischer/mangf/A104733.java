package irvine.oeis.a104;
// Generated by gen_seq4.pl trisumm/trisimple at 2023-06-09 19:35

import irvine.math.z.Fibonacci;
import irvine.math.z.Integers;
import irvine.math.z.Z;
import irvine.oeis.triangle.BaseTriangle;

/**
 * A104733 Triangle T(n,k) = sum_{j=k..n} Fibonacci(n-j+1)*Fibonacci(k+1), read by rows, 0&lt;=k&lt;=n.
 * @author Georg Fischer
 */
public class A104733 extends BaseTriangle {

  /** Construct the sequence. */
  public A104733() {
    super(0, 0, 0);
    hasRAM(true);
  }
  
  @Override
  public Z triangleElement(final int n, final int k) {
    return Integers.SINGLETON.sum(k, n, j -> Fibonacci.fibonacci(n - j + 1).multiply(Fibonacci.fibonacci(k + 1)));
  }
}
