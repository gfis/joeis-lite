package irvine.oeis.a139;
// Generated by gen_seq4.pl sigman1/sigma1s at 2023-02-28 23:52

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a000.A000041;

/**
 * A139041 Sum of divisors of the number of partitions of n.
 * @author Georg Fischer
 */
public class A139041 extends A000041 {

  {
    super.next();
  }

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma();
  }
}
