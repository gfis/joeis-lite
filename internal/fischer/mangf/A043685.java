package irvine.oeis.a043;
// manually 2021-03-04

import irvine.math.z.Z;
import irvine.oeis.a043.A043577;

/**
 * A043685 a(n)=(1/2)(n-th number whose base 2 representation has exactly 10 runs).
 * @author Georg Fischer
 */
public class A043685 extends A043577 {

  @Override
  public Z next() {
    return super.next().divide2();
  }
}
