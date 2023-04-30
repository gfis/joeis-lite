package irvine.oeis.a104;
// Generated by gen_seq4.pl knest/jaguarz at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a173.A173806;

/**
 * A104564 Number of distinct prime divisors of 77...771 (with n 7&apos;s).
 * @author Georg Fischer
 */
public class A104564 extends A173806 {

  {
    super.next();
  }
   
  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).omega());
  }
}