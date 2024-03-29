package irvine.oeis.a093;
// Generated by gen_seq4.pl knest/jaguar at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a093.A093570;

/**
 * A093572 Greatest prime factor of Product(k+prime(k): 1&lt;=k&lt;=n).
 * @author Georg Fischer
 */
public class A093572 extends A093570 {
  @Override
  public Z next() {
    return Jaguar.factor(super.next()).largestPrimeFactor();
  }
}
