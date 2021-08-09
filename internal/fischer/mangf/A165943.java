package irvine.oeis.a165;
// manually at 2021-07-05

import irvine.math.z.Z;
import irvine.oeis.a061.A061037;

/**
 * A165943 Heptasection A061037(7*n+2).
 * @author Georg Fischer
 */
public class A165943 extends A061037 {

  /** Construct the sequence. */
  public A165943() {
  }
  
  public Z next() {
    final Z result = super.next();
    for (int i = 1; i <= 6; ++i) {
      super.next();
    }
    return result;
  }
}
