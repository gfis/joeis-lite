package irvine.oeis.a246;
// manually (bisect) 2021-07-05

import irvine.math.z.Z;
import irvine.oeis.a246.A246584;


/**
 * A246587 Second trisection of A246584.
 * @author Georg Fischer
 */
public class A246587 extends A246584 {
  
  public A246587() {
    super.next();
    super.next();
  }
  
  public Z next() {
    final Z result = super.next();
    super.next();
    super.next();
    return result;
  }
}
