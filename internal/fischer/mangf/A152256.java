package irvine.oeis.a152;
// Generated by gen_seq4.pl ogf/lingf at 2023-05-27 12:40

import irvine.oeis.recur.GeneratingFunctionSequence;

/**
 * A152256 a(n) = (3^n - 1)*(3^n + 1)^2/32.
 * @author Georg Fischer
 */
public class A152256 extends GeneratingFunctionSequence {

  /** Construct the sequence. */
  public A152256() {
    super(0, "[0,1,-15,27]", "[1,-40,390,-1080,729]");
  }
}
