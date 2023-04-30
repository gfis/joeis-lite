package irvine.oeis.a244;
// Generated by gen_seq4.pl knest/jaguar at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a166.A166133;

/**
 * A244080 Largest prime factor of A166133(n).
 * @author Georg Fischer
 */
public class A244080 extends A166133 {
  @Override
  public Z next() {
    return Jaguar.factor(super.next()).largestPrimeFactor();
  }
}