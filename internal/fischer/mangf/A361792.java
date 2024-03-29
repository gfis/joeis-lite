package irvine.oeis.a361;
// Generated by gen_seq4.pl holgrep/holos at 2023-05-08 18:43

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A361792 Expansion of 1/sqrt(1 - 4*x/(1+x)^6).
 * @author Georg Fischer
 */
public class A361792 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A361792() {
    super(0, "[[0],[7,-1],[42,-7],[105,-21],[140,-35],[105,-35],[24,-17],[5,-3],[0,-1]]", "1,2,-6,-10,66,60,-750,-236,8682,-2098,-100792,80286,1162458", 0);
  }
}
