package irvine.oeis.a102;
// Generated by gen_seq4.pl A102111/parm2 at 2022-04-22 09:01

import irvine.math.z.ZUtils;
import irvine.oeis.a102.A102111;

/**
 * A102112 Iccanobirt numbers (2 of 15): a(n) = a(n-1) + R(a(n-2)) + a(n-3), where R is the digit reversal function A004086.
 * @author Georg Fischer
 */
public class A102112 extends A102111 {

  /** Construct the sequence. */
  public A102112() {
    super(mA.add(ZUtils.reverse(mB)).add(mC));
  }
}
