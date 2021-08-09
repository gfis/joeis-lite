package irvine.oeis.a043;
// manually 2021-03-04

import irvine.math.z.Z;
import irvine.oeis.a043.A043575;

/**
 * A043684 (1/2)(n-th number whose base 2 representation has exactly 8 runs).
 * @author Georg Fischer
 */
public class A043684 extends A043575 {

  @Override
  public Z next() {
    return super.next().divide2();
  }
}
