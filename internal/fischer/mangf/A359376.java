package irvine.oeis.a359;
// Generated by gen_seq4.pl holfsig/holos at 2023-05-05 23:17

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A359376 Numbers that are either odd multiples of 3 or multiples of 4. Numbers k such that A252463(k) is even.
 * @author Georg Fischer
 */
public class A359376 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A359376() {
    super(1, "[0,-1,1,0,0,0,1,-1]", "0,3,4,8,9,12,15,16,20,21,24,27", 0);
  }
}
