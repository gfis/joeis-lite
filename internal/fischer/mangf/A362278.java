package irvine.oeis.a362;
// Generated by gen_seq4.pl holgrep/holos at 2023-05-08 18:43

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A362278 Expansion of e.g.f. exp(x - 3*x^2/2).
 * @author Georg Fischer
 */
public class A362278 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A362278() {
    super(0, "[[0],[3,-3],[1],[-1]]", "1,1,-2,-8,10,106,-44,-1952", 0);
  }
}
