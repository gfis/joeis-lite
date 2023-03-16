package irvine.oeis.a299;
// Generated by gen_seq4.pl knest/jaguar at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a299.A299960;

/**
 * A299959 Least prime factor of (4^(2n+1)+1)/5, a(0) = 1.
 * @author Georg Fischer
 */
public class A299959 extends A299960 {
  @Override
  public Z next() {
    return Jaguar.factor(super.next()).leastPrimeFactor();
  }
}
