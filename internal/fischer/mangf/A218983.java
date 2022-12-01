package irvine.oeis.a218;
// Generated by gen_seq4.pl A214999/parm3 at 2022-11-27 22:13

import irvine.math.cr.CR;
import irvine.oeis.a214.A214999;
/**
 * A218983 Power ceiling sequence of sqrt(5).
 * @author Georg Fischer
 */
public class A218983 extends A214999 {

  /** Construct the sequence. */
  public A218983() {
    super(4, CR.FIVE.sqrt());
  }
}
