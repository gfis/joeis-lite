package irvine.oeis.a134;
// Generated by gen_seq4.pl holfsig/holos at 2023-05-05 23:17

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A134405 -1 before list of quadruples -2n-1, 2n+2, -2n, 2n+1.
 * @author Georg Fischer
 */
public class A134405 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A134405() {
    super(0, "[0,1,1,0,0,-1,-1]", "-1,-1,2,0,1,-3,4,-2,3,-5,6", 0);
  }
}
