package irvine.oeis.a104;
// Generated by gen_seq4.pl knest/jaguarz at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a104.A104365;

/**
 * A104368 Number of distinct prime factors of A104365(n) = A104350(n) + 1.
 * @author Georg Fischer
 */
public class A104368 extends A104365 {
  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).omega());
  }
}
