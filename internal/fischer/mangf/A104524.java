package irvine.oeis.a104;
// Generated by gen_seq4.pl knest/jaguarz at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a178.A178769;

/**
 * A104524 Number of distinct prime divisors of 55...557 (with n 5s).
 * @author Georg Fischer
 */
public class A104524 extends A178769 {

  {
    super.next();
    super.next();
  }
   
  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).omega());
  }
}
