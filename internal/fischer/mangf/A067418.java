package irvine.oeis.a067;
// Generated by gen_seq4.pl A213500/parm3 at 2022-05-01

import irvine.oeis.a000.A000045;
import irvine.oeis.a213.A213500;

/**
 * A067418 Triangle A067330 with rows read backwards.
 * @author Georg Fischer
 */
public class A067418 extends A213500 {

  /** Construct the sequence. */
  public A067418() {
    super(new A000045(), new A000045());
  }

  @Override
  public int getOffset() {
    return 0;
  }

}
