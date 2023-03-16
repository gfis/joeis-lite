package irvine.oeis.a062;
// Generated by gen_seq4.pl sigma0 at 2023-02-28 13:16

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a036.A036740;

/**
 * A062960 Number of divisors of (n!)^n (A036740).
 * @author Georg Fischer
 */
public class A062960 extends A036740 {

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma0();
  }
}
