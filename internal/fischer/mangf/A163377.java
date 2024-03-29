package irvine.oeis.a163;
// Generated by gen_seq4.pl knest/jaguar at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a163.A163109;

/**
 * A163377 a(n) = tau(phi(tau(n))).
 * @author Georg Fischer
 */
public class A163377 extends A163109 {
  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma0();
  }
}
