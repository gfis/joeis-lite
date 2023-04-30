package irvine.oeis.a104;
// Generated by gen_seq4.pl knest/jaguarz at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a005.A005904;

/**
 * A104011 Number of prime factors (with multiplicity) of centered dodecahedral numbers (A005904).
 * @author Georg Fischer
 */
public class A104011 extends A005904 {
  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).bigOmega());
  }
}