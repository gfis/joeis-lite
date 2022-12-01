package irvine.oeis.a113;

import irvine.math.z.Binomial;
import irvine.math.z.Fibonacci;
import irvine.math.z.Z;
import irvine.oeis.Sequence0;

/**
 * A081667 a(n) = Fibonacci(binomial(n+2,2))
 * @author Georg Fischer
 */
public class A081667 extends Sequence0 {

  private int mN = -1;

  @Override
  public Z next() {
    ++mN;
    return Fibonacci.fibonacci(Binomial.binomial(mN + 2, 2).intValue());
  }
}
