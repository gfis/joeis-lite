package irvine.oeis.a358;
// Generated by gen_seq4.pl multm/simple1 at 2023-03-28 18:24

import irvine.factor.factor.Jaguar;
import irvine.math.z.Integers;
import irvine.math.z.Z;
import irvine.oeis.Sequence1;

/**
 * A358380 a(n) = Sum_{d|n} tau(d^5), where tau(n) = number of divisors of n, cf. A000005.
 * @author Georg Fischer
 */
public class A358380 extends Sequence1 {

  private int mN = 0; 

  @Override
  public Z next() {
    ++mN;
    return Integers.SINGLETON.sumdiv(mN,d -> Jaguar.factor(Z.valueOf(d).pow(5)).tau());
  }
}
