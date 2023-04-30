package irvine.oeis.a102;
// Generated by gen_seq4.pl sigman1/sigma1s at 2023-02-28 23:52

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a002.A002283;

/**
 * A102146 a(n) = sigma(10^n - 1), where sigma(n) is the sum of positive divisors of n.
 * @author Georg Fischer
 */
public class A102146 extends A002283 {

  {
    super.next();
  }

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma();
  }
}