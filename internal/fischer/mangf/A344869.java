package irvine.oeis.a344;
// Generated by gen_seq4.pl knest/jaguarz at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a014.A014566;

/**
 * A344869 Number of distinct prime factors of n^n+1.
 * @author Georg Fischer
 */
public class A344869 extends A014566 {
  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).omega());
  }
}
