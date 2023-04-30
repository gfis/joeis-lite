package irvine.oeis.a195;
// Generated by gen_seq4.pl knest/jaguar at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a016.A016105;

/**
 * A195758 Lesser prime factor of n-th Blum number.
 * @author Georg Fischer
 */
public class A195758 extends A016105 {
  @Override
  public Z next() {
    return Jaguar.factor(super.next()).leastPrimeFactor();
  }
}