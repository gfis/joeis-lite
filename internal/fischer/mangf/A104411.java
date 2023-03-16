package irvine.oeis.a104;
// manually knest/jaguarz at 2023-03-01 16:41

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a000.A000078;

/**
 * A104411 Number of prime factors, with multiplicity, of the tetranacci numbers A000078.
 * @author Georg Fischer
 */
public class A104411 extends A000078 {
  {
    super.next();
    super.next();
    super.next();
  }

  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).bigOmega());
  }
}
