package irvine.oeis.a180;

import irvine.math.z.Z;
import irvine.math.z.Fibonacci;
import irvine.oeis.a000.A000040;

/**
 * A180363 a(n) = Lucas(prime(n)).
 * @author Georg Fischer
 */
public class A180363 extends A000040 {

  @Override
  public Z next() {
    return Fibonacci.lucas(super.next().intValue());
  }
}
