package irvine.oeis.a130;
// manually triprod at 2023-06-05 09:05

import irvine.math.z.Fibonacci;
import irvine.math.z.Integers;
import irvine.math.z.Z;
import irvine.oeis.Sequence1;
import irvine.oeis.a001.A001519;

/**
 * A130095 Inverse Moebius transform of odd-indexed Fibonacci numbers.
 * @author Georg Fischer
 */
public class A130095 extends Sequence1 {

  private int mN = 0;
  
  @Override
  public Z next() {
    // a(n) = sum {d | n} Fibonacci(2*d - 1).
    ++mN;
    return Integers.SINGLETON.sumdiv(mN, d -> Fibonacci.fibonacci(2 * d - 1));
  }
}
