package irvine.oeis.a281;
// manually etman at 2023-02-06 12:43

import irvine.math.z.Z;
import irvine.oeis.Sequence0;
import irvine.oeis.a122.A122865;

/**
 * A281452 Expansion of f(x, x) * f(x^5, x^13) in powers of x where f(, ) is Ramanujan&apos;s general theta function.
 * <code>a(n) = A122865(3*n + 1).</code>
 * @author Georg Fischer
 */
public class A281452 extends Sequence0 {

  private A122865 mSeq = new A122865();

  public Z next() {
    mSeq.next();
    final Z result = mSeq.next();
    mSeq.next();
    return result;
  }
}
