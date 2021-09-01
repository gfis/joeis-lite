package irvine.oeis.a199;
// manually 2021-09-01

import irvine.math.z.Z;
import irvine.oeis.a048.A048153;

/**
 * A199117 Integer values of A048153(n)/n.
 * @author Georg Fischer
 */
public class A199117 extends A048153 {

  protected long mN;

  /** Construct the sequence. */
  public A199117() {
    mN = 0; // but offset = 0
  }

  @Override
  public Z next() {
    while (true) {
      ++mN;
      final Z [] quot = super.next().divideAndRemainder(Z.valueOf(mN));
      if (quot[1].isZero()) {
        return quot[0];
      }
    }
  }

}
