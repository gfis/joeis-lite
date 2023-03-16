package irvine.oeis.a185;
// Generated by gen_seq4.pl knest/jaguarz at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a034.A034090;

/**
 * A185166 Number of prime divisors of n (counted with multiplicity) of numbers k such that sum of proper divisors of k exceeds that of all smaller numbers.
 * @author Georg Fischer
 */
public class A185166 extends A034090 {
  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).bigOmega());
  }
}
