package irvine.oeis.a163;
// Generated by gen_seq4.pl sigman1/eulphi at 2023-03-01 11:35

import irvine.math.z.Euler;
import irvine.math.z.Z;
import irvine.oeis.a062.A062402;

/**
 * A163370 a(n) = phi(sigma(phi(n))).
 * @author Georg Fischer
 */
public class A163370 extends A062402 {

  @Override
  public Z next() {
    return Euler.phi(super.next());
  }
}