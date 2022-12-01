package irvine.oeis.a121;

import irvine.math.z.Fibonacci;
import irvine.math.z.Z;
import irvine.oeis.a000.A000040;

/**
 * A121567 Fibonacci[ (p - 1) ], where p = Prime[n].
 * @author Georg Fischer
 */
public class A121567 extends A000040 {

  @Override
  public Z next() {
    return Fibonacci.fibonacci(super.next().intValue() - 1);
  }
}
