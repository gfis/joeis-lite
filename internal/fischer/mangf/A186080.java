package irvine.oeis.a186;
// Generated by gen_seq4.pl knestm/knest at 2023-03-02 20:40

import irvine.math.z.Z;
import irvine.oeis.a056.A056810;

/**
 * A186080 Fourth powers that are palindromic in base 10.
 * @author Georg Fischer
 */
public class A186080 extends A056810 {
  @Override
  public Z next() {
    return super.next().pow(4);
  }
}
