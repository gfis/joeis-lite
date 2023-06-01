package irvine.oeis.a334;
// Generated by gen_seq4.pl holgrep/holos at 2023-05-08 18:43

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A334509 Eventual period of a single cell in rule 41 cellular automaton in a cyclic universe of width n.
 * @author Georg Fischer
 */
public class A334509 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A334509() {
    super(1, "[[0],[-1],[0],[0],[0],[2],[0],[0],[0],[-1]]", "2,2,2,2,15,2,28,8,36,20,44,12,52,28", 0);
  }
}