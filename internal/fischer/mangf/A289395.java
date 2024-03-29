package irvine.oeis.a289;
// Generated by gen_seq4.pl knestm/knest at 2023-03-02 20:40

import irvine.math.z.Z;
import irvine.oeis.a110.A110163;

/**
 * A289395 a(n) = A110163(n)/8.
 * @author Georg Fischer
 */
public class A289395 extends A110163 {
  @Override
  public Z next() {
    return super.next().divide(8);
  }
}
