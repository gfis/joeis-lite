package irvine.oeis.a078;
// Generated by gen_seq4.pl knestm/knest at 2023-03-02 20:40

import irvine.math.z.Z;
import irvine.oeis.a060.A060355;

/**
 * A078326 Numbers n such that n-1 and n are a pair of consecutive powerful numbers.
 * @author Georg Fischer
 */
public class A078326 extends A060355 {
  @Override
  public Z next() {
    return super.next().add(1);
  }
}
