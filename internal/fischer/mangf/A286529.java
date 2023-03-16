package irvine.oeis.a286;
// Generated by gen_seq4.pl sigman0/sigma0 at 2023-02-28 16:47

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a062.A062249;

/**
 * A286529 a(n) = d(n+d(n)), where d(n) is the number of divisors of n (A000005).
 * @author Georg Fischer
 */
public class A286529 extends A062249 {

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma0();
  }
}
