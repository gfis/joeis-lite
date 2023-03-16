package irvine.oeis.a339;
// Generated by gen_seq4.pl knest/jaguarz at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a339.A339809;

/**
 * A339812 Number of prime divisors of (A019565(n) - 1), counted with multiplicity.
 * @author Georg Fischer
 */
public class A339812 extends A339809 {

  {
    super.next();
  }
   
  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).bigOmega());
  }
}
