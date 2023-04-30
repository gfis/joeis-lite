package irvine.oeis.a067;
// Generated by gen_seq4.pl sigman1/sigma1s at 2023-02-28 23:52

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a000.A000984;

/**
 * A067819 Sum of the divisors of binomial(2n,n).
 * @author Georg Fischer
 */
public class A067819 extends A000984 {

  {
    super.next();
  }

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma();
  }
}