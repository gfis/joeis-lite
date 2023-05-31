package irvine.oeis.a348;

import irvine.math.z.Z;
import irvine.oeis.a347.A347950;

/**
 * A348364 Number of vertices on the axis of symmetry of the symmetric representation of sigma(n).
 * @author Georg Fischer
 */
public class A348364 extends A347950 {

  @Override
  public Z next() {
    return super.next().subtract(1);
  }
}
