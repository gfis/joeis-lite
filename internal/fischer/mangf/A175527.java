package irvine.oeis.a175;
// Generated by gen_seq4.pl knest at 2023-03-02 20:46

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.a001.A001022;

/**
 * A175527 Digit sum of 13^n.
 * @author Georg Fischer
 */
public class A175527 extends A001022 {
  @Override
  public Z next() {
    return Z.valueOf(ZUtils.digitSum(super.next()));
  }
}
