package irvine.oeis.a067;
// Generated by gen_seq4.pl knest/jaguarz at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a000.A000984;

/**
 * A067434 Number of distinct prime factors in binomial(2*n,n).
 * @author Georg Fischer
 */
public class A067434 extends A000984 {

  {
    super.next();
  }
   
  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).omega());
  }
}