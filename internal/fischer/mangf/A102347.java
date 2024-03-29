package irvine.oeis.a102;
// Generated by gen_seq4.pl knest/jaguarz at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a002.A002283;

/**
 * A102347 Number of distinct prime factors of 10^n - 1.
 * @author Georg Fischer
 */
public class A102347 extends A002283 {

  {
    super.next();
  }
   
  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).omega());
  }
}
