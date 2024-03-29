package irvine.oeis.a327;
// Generated by gen_seq4.pl holgrep/holos at 2023-05-08 18:43

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A327021 a(n) = (2*n-1)! / 2^(n-1) if n &gt; 0 and a(0) = 1.
 * @author Georg Fischer
 */
public class A327021 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A327021() {
    super(0, "[[0],[-12,20,-11,2],[2,0,-3,2],[0,-1]]", "1,1,3,30,630,22680,1247400,97297200", 0);
  }
}
