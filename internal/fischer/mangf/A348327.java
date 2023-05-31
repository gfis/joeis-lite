package irvine.oeis.a348;

import irvine.math.z.Z;
import irvine.oeis.a347.A347950;

/**
 * A348327 Characteristic function of numbers that have no middle divisors.
 * @author Georg Fischer
 */
public class A348327 extends A347950 {

  @Override
  public Z next() {
    return Z.TWO.subtract(super.next());
  }
}
