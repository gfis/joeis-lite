package irvine.oeis.a357;
// Generated by gen_seq4.pl greprec3/holos at 2023-05-08 15:06

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A357599 Expansion of e.g.f. sinh(2 * log(1+x)) / 2.
 * @author Georg Fischer
 */
public class A357599 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A357599() {
    super(0, "[[0],[1,1],[1]]", "0,1,-1,6,-30,180,-1260", 0);
  }
}