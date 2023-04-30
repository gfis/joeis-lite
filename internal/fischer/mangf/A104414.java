package irvine.oeis.a104;
// Generated by gen_seq4.pl knest/jaguarz at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a066.A066178;

/**
 * A104414 Number of prime factors, with multiplicity, of the heptanacci numbers A066178.
 * @author Georg Fischer
 */
public class A104414 extends A066178 {
  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).bigOmega());
  }
}