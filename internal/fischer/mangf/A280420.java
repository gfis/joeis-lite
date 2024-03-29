package irvine.oeis.a280;
// Generated by gen_seq4.pl knest at 2023-03-02 20:46

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a000.A000142;

/**
 * A280420 Product of divisors of n!.
 * @author Georg Fischer
 */
public class A280420 extends A000142 {
  @Override
  public Z next() {
    return Jaguar.factor(super.next()).pod();
  }
}
