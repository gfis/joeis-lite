package irvine.oeis.a354;
// Generated by gen_seq4.pl holdfin/holos at 2023-05-05 23:15

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A354019 G.f. A(x) satisfies: A(x)^3 = 36*x + 1/A(x)^3.
 * @author Georg Fischer
 */
public class A354019 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A354019() {
    super(0, "[[0],[1260,-1296,324],[0],[0,-1,1]]", "1,6,18,-288,-1890,41472,324324,-7962624", 0);
  }
}
