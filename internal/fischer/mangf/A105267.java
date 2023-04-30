package irvine.oeis.a105;
// Generated by gen_seq4.pl sigman0/sigma0 at 2023-02-28 16:47

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a033.A033175;

/**
 * A105267 a(n) = the number of divisors of 33...31, with n 3s.
 * @author Georg Fischer
 */
public class A105267 extends A033175 {

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma0();
  }
}