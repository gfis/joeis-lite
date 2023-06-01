package irvine.oeis.a360;
// Generated by gen_seq4.pl holgrep/holos at 2023-05-08 18:43

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A360315 a(n) = Sum_{k=0..floor(n/4)} (-1)^k * binomial(n-1-3*k,n-4*k) * binomial(2*k,k).
 * @author Georg Fischer
 */
public class A360315 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A360315() {
    super(0, "[[0],[-14,4],[8,-4],[0],[2,-1],[-2,2],[0,-1]]", "1,0,0,0,-2,-2,-2,-2,4,10,16", 0);
  }
}