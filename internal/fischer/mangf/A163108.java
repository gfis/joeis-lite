package irvine.oeis.a163;
// Generated by gen_seq4.pl sigman1/sigma1 at 2023-03-01 11:35

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a062.A062068;

/**
 * A163108 a(n) = sigma(tau(sigma(n))).
 * @author Georg Fischer
 */
public class A163108 extends A062068 {

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma();
  }
}