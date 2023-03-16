package irvine.oeis.a163;
// Generated by gen_seq4.pl sigman1/sigma1 at 2023-03-01 11:35

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a062.A062402;

/**
 * A163369 a(n) = sigma(sigma(phi(n))).
 * @author Georg Fischer
 */
public class A163369 extends A062402 {

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma();
  }
}
