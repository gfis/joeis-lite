package irvine.oeis.a064;
// Generated by gen_seq4.pl sigman1/sigma1s at 2023-02-28 23:52

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a001.A001405;

/**
 * A064139 Sum of divisors of central binomial coefficient C(n, floor(n/2)).
 * @author Georg Fischer
 */
public class A064139 extends A001405 {

  {
    super.next();
  }

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma();
  }
}
