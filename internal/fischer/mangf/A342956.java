package irvine.oeis.a342;
// Generated by gen_seq4.pl knest/jaguarz at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a001.A001414;

/**
 * A342956 a(n) =  A001222(A001414(n)).
 * @author Georg Fischer
 */
public class A342956 extends A001414 {
  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).bigOmega());
  }
}
