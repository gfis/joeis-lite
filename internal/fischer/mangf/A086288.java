package irvine.oeis.a086;
// Generated by gen_seq4.pl knest/jaguarz at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a002.A002473;

/**
 * A086288 Number of distinct prime factors of 7-smooth numbers.
 * @author Georg Fischer
 */
public class A086288 extends A002473 {
  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).omega());
  }
}
