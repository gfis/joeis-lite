package irvine.oeis.a114;
// Generated by gen_seq4.pl sigman0/sigma0 at 2023-02-28 16:47

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a006.A006882;

/**
 * A114338 Number of divisors of n!! (double factorial = A006882(n)).
 * @author Georg Fischer
 */
public class A114338 extends A006882 {

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma0();
  }
}