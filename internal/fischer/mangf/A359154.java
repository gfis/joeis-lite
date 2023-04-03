package irvine.oeis.a359;
// Generated by gen_seq4.pl multm/simple1 at 2023-03-28 18:24

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.Sequence1;

/**
 * A359154 a(n) = (-1)^sopfr(n), where sopfr is the sum of prime factors with repetition.
 * @author Georg Fischer
 */
public class A359154 extends Sequence1 {

  private int mN = 0; 

  @Override
  public Z next() {
    ++mN;
    return Jaguar.factor(mN).sopfr().isEven() ? Z.ONE : Z.NEG_ONE;
  }
}
