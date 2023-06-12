package irvine.oeis.a355;
// Generated by gen_seq4.pl knest at 2023-06-02 20:44

import irvine.math.z.Z;
import irvine.oeis.a033.A033015;

/**
 * A355280 Binary numbers (digits in {0, 1}) with no run of digits with length &lt; 2.
 * @author Georg Fischer
 */
public class A355280 extends A033015 {
  @Override
  public Z next() {
    return new Z(super.next().toString(2));
  }
}
