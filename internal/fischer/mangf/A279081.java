package irvine.oeis.a279;
// Generated by gen_seq4.pl sigman0/sigma0s at 2023-02-28 16:47

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a000.A000292;

/**
 * A279081 Number of divisors of the n-th tetrahedral number.
 * @author Georg Fischer
 */
public class A279081 extends A000292 {

  {
    super.next();
  }

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma0();
  }
}