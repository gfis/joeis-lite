package irvine.oeis.a230;
// Generated by gen_seq4.pl knest at 2023-03-02 20:46

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.a000.A000073;

/**
 * A230724 Digital sum of tribonacci numbers with a(0)=a(1)=0, a(2)=1.
 * @author Georg Fischer
 */
public class A230724 extends A000073 {
  @Override
  public Z next() {
    return Z.valueOf(ZUtils.digitSum(super.next()));
  }
}
