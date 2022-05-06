package irvine.oeis.a203;

import irvine.math.z.Z;
import irvine.oeis.a203.A203753;

/**
 * A203754 Square root of A203753(n).
 * @author Georg Fischer
 */
public class A203754 extends A203753 {

  @Override
  public Z next() {
    return super.next().sqrt();
  }
}
