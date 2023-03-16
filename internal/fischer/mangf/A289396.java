package irvine.oeis.a289;
// Generated by gen_seq4.pl knestm/knest at 2023-03-02 20:40

import irvine.math.z.Z;
import irvine.oeis.a288.A288851;

/**
 * A289396 a(n) = A288851(n)/12.
 * @author Georg Fischer
 */
public class A289396 extends A288851 {
  @Override
  public Z next() {
    return super.next().divide(12);
  }
}
