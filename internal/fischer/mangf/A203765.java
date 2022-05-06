package irvine.oeis.a203;

import irvine.math.z.Z;
import irvine.oeis.a203.A203764;

/**
 * A203765 Square root of A203764(n).
 * @author Georg Fischer
 */
public class A203765 extends A203764 {

  @Override
  public Z next() {
    return super.next().sqrt();
  }
}
