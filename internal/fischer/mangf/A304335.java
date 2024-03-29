package irvine.oeis.a304;
// Generated by gen_seq4.pl knest at 2023-03-02 20:46

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.a001.A001147;

/**
 * A304335 Sum of digits of (2*n-1)!!.
 * @author Georg Fischer
 */
public class A304335 extends A001147 {
  @Override
  public Z next() {
    return Z.valueOf(ZUtils.digitSum(super.next()));
  }
}
