package irvine.oeis.a347;
// Generated by gen_seq4.pl recuf7/holos at 2023-06-02 21:34

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A347051 a(0) = 1, a(1) = 2; a(n) = n * (n+1) * a(n-1) + a(n-2).
 * @author Georg Fischer
 */
public class A347051 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A347051() {
    super(0, "[[0],[-1],[0,-1,-1],[1]]", "[1,2,13]", 0);
  }
}
