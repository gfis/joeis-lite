package irvine.oeis.a162;
// Generated by gen_seq4.pl knest/jaguar at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a071.A071904;

/**
 * A162022 Smallest prime factor of n-th odd composite integers A071904.
 * @author Georg Fischer
 */
public class A162022 extends A071904 {
  @Override
  public Z next() {
    return Jaguar.factor(super.next()).leastPrimeFactor();
  }
}
