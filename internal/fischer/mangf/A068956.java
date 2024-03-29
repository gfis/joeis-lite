package irvine.oeis.a068;
// Generated by gen_seq4.pl knest/jaguarz at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a007.A007781;

/**
 * A068956 Number of distinct prime factors of n^n - (n-1)^(n-1).
 * @author Georg Fischer
 */
public class A068956 extends A007781 {

  {
    super.next();
  }
   
  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).omega());
  }
}
