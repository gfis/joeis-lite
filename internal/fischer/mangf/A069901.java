package irvine.oeis.a069;
// Generated by gen_seq4.pl knest/jaguar at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a000.A000217;

/**
 * A069901 Smallest prime factor of n-th triangular number.
 * @author Georg Fischer
 */
public class A069901 extends A000217 {

  {
    super.next();
  }
   
  @Override
  public Z next() {
    return Jaguar.factor(super.next()).leastPrimeFactor();
  }
}
