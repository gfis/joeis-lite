package irvine.oeis.a360;
// Generated by gen_seq4.pl holdfin/holos at 2023-05-05 23:15

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A360272 a(n) = Sum_{k=0..floor(n/3)} binomial(n-3*k,k) * Catalan(n-3*k).
 * @author Georg Fischer
 */
public class A360272 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A360272() {
    super(0, "[[0],[20,-4],[0],[0],[22,-8],[1,1],[0],[2,-4],[1,1]]", "1,1,2,5,15,46,147,485,1642,5669,19883,70646,253755", 0);
  }
}