package irvine.oeis.a362;
// Generated by gen_seq4.pl holgrep/holos at 2023-05-08 18:43

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A362176 Expansion of e.g.f. exp(x * (1-2*x)).
 * @author Georg Fischer
 */
public class A362176 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A362176() {
    super(0, "[[0],[4,-4],[1],[-1]]", "1,1,-3,-11,25,201,-299,-5123", 0);
  }
}
