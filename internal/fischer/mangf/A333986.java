package irvine.oeis.a333;
// Generated by gen_seq4.pl knest/jaguar at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a007.A007497;

/**
 * A333986 Greatest prime factor of A007497(n).
 * @author Georg Fischer
 */
public class A333986 extends A007497 {
  @Override
  public Z next() {
    return Jaguar.factor(super.next()).largestPrimeFactor();
  }
}
