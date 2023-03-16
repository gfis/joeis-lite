package irvine.oeis.a280;
// manually sigman1/sigma1 at 2023-02-28 22:58

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a139.A139041;

/**
 * A280101 a(n) = sigma(sigma(p(n)) = sum of the divisors of the sum of the divisors of number of partitions of n.
 * @author Georg Fischer
 */
public class A280101 extends A139041 {

  private int mN = 0;

  @Override
  public Z next() {
    return (++mN == 1) ? Z.ONE : Jaguar.factor(super.next()).sigma();
  }
}
