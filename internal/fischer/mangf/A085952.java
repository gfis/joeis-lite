package irvine.oeis.a085;
// Generated by gen_seq4.pl holfsig/holos at 2023-05-05 23:17

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A085952 First n-digit number that occurs in the sequence A085951.
 * @author Georg Fischer
 */
public class A085952 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A085952() {
    super(0, "[0,-10,11,-1]", "1,91,901,9001,90001,900001,9000001,90000001", 0);
  }
}
