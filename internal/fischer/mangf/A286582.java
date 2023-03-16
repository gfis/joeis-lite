package irvine.oeis.a286;
// Generated by gen_seq4.pl knest/jaguarz at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a048.A048673;

/**
 * A286582 a(n) = A001222(A048673(n)).
 * @author Georg Fischer
 */
public class A286582 extends A048673 {
  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).bigOmega());
  }
}
