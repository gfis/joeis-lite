package irvine.oeis.a352;
// Generated by gen_seq4.pl hygsolve/holos at 2022-07-30 20:58

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A352756 Positive numbers k such that the centered cube number k^3 + (k+1)^3 is equal to the difference of two positive cubes and to A352755(n).
 * @author Georg Fischer
 */
public class A352756 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A352756() {
    super(1, "[[0],[-1],[4],[-6],[4],[-1]]", "3,46,197,528", 0);
  }
}