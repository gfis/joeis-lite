package irvine.oeis.a362;
// Generated by gen_seq4.pl holgrep/holos at 2023-05-08 18:43

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A362279 Expansion of e.g.f. exp(x - 5*x^2/2).
 * @author Georg Fischer
 */
public class A362279 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A362279() {
    super(0, "[[0],[5,-5],[1],[-1]]", "1,1,-4,-14,46,326,-824,-10604", 0);
  }
}