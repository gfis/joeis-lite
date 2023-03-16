package irvine.oeis.a230;
// Generated by gen_seq4.pl knest at 2023-03-02 20:46

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.a002.A002385;

/**
 * A230199 Sum of digits of n-th palindromic prime.
 * @author Georg Fischer
 */
public class A230199 extends A002385 {
  @Override
  public Z next() {
    return Z.valueOf(ZUtils.digitSum(super.next()));
  }
}
