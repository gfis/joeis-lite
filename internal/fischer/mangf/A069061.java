package irvine.oeis.a069;
// Generated by gen_seq4.pl sigman1/sigma1s at 2023-02-28 23:52

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a000.A000051;

/**
 * A069061 Sum of divisors of 2^n+1.
 * @author Georg Fischer
 */
public class A069061 extends A000051 {

  {
    super.next();
  }

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma();
  }
}
