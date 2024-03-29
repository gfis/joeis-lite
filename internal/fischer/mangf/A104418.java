package irvine.oeis.a104;
// manually knest/jaguarz at 2023-03-01 16:41

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a104.A104144;

/**
 * A104418 Number of prime factors, with multiplicity, of the nonzero 9-acci numbers.
 * @author Georg Fischer
 */
public class A104418 extends A104144 {

  {
    for (int i = 0; i < 8; ++i) {
      super.next();
    }
  }

  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).bigOmega());
  }
}
