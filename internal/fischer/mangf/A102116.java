package irvine.oeis.a102;
// Generated by gen_seq4.pl A102111/parm2 at 2022-04-22 09:01

import irvine.math.z.ZUtils;
import irvine.oeis.a102.A102111;

/**
 * A102116 Iccanobirt numbers (6 of 15): a(n) = R(a(n-1)) + R(a(n-2)) + a(n-3), where R is the digit reversal function A004086.
 * @author Georg Fischer
 */
public class A102116 extends A102111 {

  /** Construct the sequence. */
  public A102116() {
    super(ZUtils.reverse(mA).add(ZUtils.reverse(mB)).add(mC));
  }
}
