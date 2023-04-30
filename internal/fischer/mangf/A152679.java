package irvine.oeis.a152;
// Generated by gen_seq4.pl knestm/knest at 2023-03-02 20:40

import irvine.math.z.Z;
import irvine.oeis.a152.A152678;

/**
 * A152679 Even members of A000203, divided by 2.
 * @author Georg Fischer
 */
public class A152679 extends A152678 {
  @Override
  public Z next() {
    return super.next().divide2();
  }
}