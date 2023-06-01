package irvine.oeis.a360;
// Generated by gen_seq4.pl holdfin/holos at 2023-05-05 23:15

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A360271 a(n) = Sum_{k=0..floor(n/3)} (-1)^k * binomial(n-3*k,k) * Catalan(n-3*k).
 * @author Georg Fischer
 */
public class A360271 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A360271() {
    super(0, "[[0],[20,-4],[0],[0],[-22,8],[-1,-1],[0],[2,-4],[1,1]]", "1,1,2,5,13,38,117,373,1222,4085,13877,47766,166229", 0);
  }
}