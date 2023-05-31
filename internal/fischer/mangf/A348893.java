package irvine.oeis.a348;
// Generated by gen_seq4.pl binomin/holos at 2023-05-08 14:44

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A348893 a(n) = 840*(2*n)!/((n + 4)!*n!).
 * @author Georg Fischer
 */
public class A348893 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A348893() {
    super(0, "[[0],[2,-4],[4,1]]", "[35,14]", 0);
  }
}
