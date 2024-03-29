package irvine.oeis.a275;
// Generated by gen_seq4.pl knest/jaguar at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a084.A084920;

/**
 * A275630 a(n) = product of distinct primes dividing prime(n)^2 - 1.
 * @author Georg Fischer
 */
public class A275630 extends A084920 {
  @Override
  public Z next() {
    return Jaguar.factor(super.next()).squareFreeKernel();
  }
}
