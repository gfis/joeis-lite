package irvine.oeis.a066;
// Generated by gen_seq4.pl knest/eulphi at 2023-03-01 20:54

import irvine.math.z.Euler;
import irvine.math.z.Z;
import irvine.oeis.a053.A053698;

/**
 * A066792 a(n) = phi(n^3 + n^2 + n + 1).
 * @author Georg Fischer
 */
public class A066792 extends A053698 {
  @Override
  public Z next() {
    return Euler.phi(super.next());
  }
}
