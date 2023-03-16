package irvine.oeis.a247;
// Generated by gen_seq4.pl sigman1/sigma1 at 2023-02-28 23:52

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a100.A100484;

/**
 * A247159 Sum of divisors of even semiprimes.
 * @author Georg Fischer
 */
public class A247159 extends A100484 {

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma();
  }
}
