package irvine.oeis.a358;
// Generated by gen_seq4.pl holfsig/holos at 2023-05-05 23:17

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A358012 Minimal number of coins needed to pay n cents using coins of denominations 1 and 5 cents.
 * @author Georg Fischer
 */
public class A358012 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A358012() {
    super(0, "[0,-1,1,0,0,0,1,-1]", "0,1,2,3,4,1,2,3,4,5,2,3", 0);
  }
}