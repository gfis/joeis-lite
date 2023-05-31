package irvine.oeis.a359;
// Generated by gen_seq4.pl holfsig/holos at 2023-05-05 23:17

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A359379 a(n) = 1 if n is either a multiple of 4, or an odd multiple of 3, otherwise 0.
 * @author Georg Fischer
 */
public class A359379 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A359379() {
    super(0, "[0,1,0,1,0,0,0,-1,0,-1]", "1,0,0,1,1,0,0,0,1,1,0,0,1,0", 0);
  }
}
