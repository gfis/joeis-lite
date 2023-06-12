package irvine.oeis.a351;
// Generated by gen_seq4.pl recuf7/holos at 2023-06-02 21:34

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A351531 a(0)=1; a(1)=1; for n&gt;1, a(n) = a(n-1) + 3*n*a(n-2).
 * @author Georg Fischer
 */
public class A351531 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A351531() {
    super(0, "[[0],[0,-3],[-1],[1]]", "[1,1,7]", 0);
  }
}
