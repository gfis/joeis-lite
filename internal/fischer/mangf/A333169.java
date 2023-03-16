package irvine.oeis.a333;
// Generated by gen_seq4.pl knest/eulphi at 2023-03-01 20:54

import irvine.math.z.Euler;
import irvine.math.z.Z;
import irvine.oeis.a002.A002522;

/**
 * A333169 a(n) = phi(n^2 + 1), where phi is the Euler totient function (A000010).
 * @author Georg Fischer
 */
public class A333169 extends A002522 {
  @Override
  public Z next() {
    return Euler.phi(super.next());
  }
}
