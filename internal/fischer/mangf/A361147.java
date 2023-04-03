package irvine.oeis.a361;
// Generated by gen_seq4.pl multm/simple1 at 2023-03-28 18:24

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.Sequence1;

/**
 * A361147 a(n) = sigma(n)^3.
 * @author Georg Fischer
 */
public class A361147 extends Sequence1 {

  private int mN = 0; 

  @Override
  public Z next() {
    ++mN;
    return Jaguar.factor(mN).sigma().pow(3);
  }
}
