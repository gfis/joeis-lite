package irvine.oeis.a271;
// Generated by gen_seq4.pl knest/jaguarz at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a060.A060354;

/**
 * A271320 Number of prime factors, with multiplicity, of the n-th n-gonal number (A060354).
 * @author Georg Fischer
 */
public class A271320 extends A060354 {

  {
    super.next();
    super.next();
  }
   
  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).bigOmega());
  }
}
