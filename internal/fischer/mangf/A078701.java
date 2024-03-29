package irvine.oeis.a078;
// Generated by gen_seq4.pl knest/jaguar at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a000.A000265;

/**
 * A078701 Least odd prime factor of n, or 1 if no such factor exists.
 * @author Georg Fischer
 */
public class A078701 extends A000265 {
  @Override
  public Z next() {
    return Jaguar.factor(super.next()).leastPrimeFactor();
  }
}
