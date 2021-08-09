package irvine.oeis.a246;
// manually (bisect) 2021-07-05

import irvine.math.z.Z;
import irvine.oeis.a246.A246584;

/**
 * A246585 Zeroth trisection of A246584.
 * @author Georg Fischer
 */
public class A246585 extends A246584 {
  
  public A246585() {
  }
  
  public Z next() {
    final Z result = super.next();
    super.next();
    super.next();
    return result;
  }
}
