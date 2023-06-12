package irvine.oeis.a361;
// manually knest at 2023-06-02 20:44

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a000.A000292;

/**
 * A361671 Squarefree part of the n-th tetrahedral number.
 * @author Georg Fischer
 */
public class A361671 extends A000292 {

  {
    super.next();
  }

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).core();
  }
}
