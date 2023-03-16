package irvine.oeis.a087;
// Generated by gen_seq4.pl knest/jaguarz at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a000.A000041;

/**
 * A087175 Number of distinct primes dividing the n-th partition number.
 * @author Georg Fischer
 */
public class A087175 extends A000041 {

  {
    super.next();
  }
   
  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).omega());
  }
}
