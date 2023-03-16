package irvine.oeis.a073;
// Generated by gen_seq4.pl sigman0/sigma0 at 2023-02-28 16:47

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a001.A001157;

/**
 * A073806 Number of divisors of sum of square of divisors.
 * @author Georg Fischer
 */
public class A073806 extends A001157 {

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma0();
  }
}
