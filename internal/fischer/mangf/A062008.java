package irvine.oeis.a062;
// Generated by gen_seq4.pl sigma0 at 2023-02-28 13:16

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a000.A000197;

/**
 * A062008 Number of divisors of (n!)!, or A000197.
 * @author Georg Fischer
 */
public class A062008 extends A000197 {

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma0();
  }
}