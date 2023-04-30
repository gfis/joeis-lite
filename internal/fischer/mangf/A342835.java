package irvine.oeis.a342;
// Generated by gen_seq4.pl sigman0/sigma0 at 2023-02-28 16:47

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a342.A342834;

/**
 * A342835 a(n) is the number of divisors of A342834(n).
 * @author Georg Fischer
 */
public class A342835 extends A342834 {

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma0();
  }
}