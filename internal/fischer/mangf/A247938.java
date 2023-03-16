package irvine.oeis.a247;
// Generated by gen_seq4.pl sigman1/sigma1 at 2023-02-28 23:52

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a001.A001348;

/**
 * A247938 Sum of divisors of 2^prime(n)-1.
 * @author Georg Fischer
 */
public class A247938 extends A001348 {

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma();
  }
}
