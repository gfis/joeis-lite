package irvine.oeis.a346;
// Generated by gen_seq4.pl recuf7/holos at 2023-06-02 21:34

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A346960 a(0) = 0, a(1) = 1; a(n) = n * (n+1) * a(n-1) + a(n-2).
 * @author Georg Fischer
 */
public class A346960 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A346960() {
    super(0, "[[0],[-1],[0,-1,-1],[1]]", "[0,1,6]", 0);
  }
}
