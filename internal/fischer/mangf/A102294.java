package irvine.oeis.a102;
// Generated by gen_seq4.pl knest/jaguarz at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a006.A006564;

/**
 * A102294 Number of prime divisors (with multiplicity) of icosahedral numbers.
 * @author Georg Fischer
 */
public class A102294 extends A006564 {
  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).bigOmega());
  }
}
