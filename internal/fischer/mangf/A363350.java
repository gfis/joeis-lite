package irvine.oeis.a363;
// Generated by gen_seq4.pl robot/lingf at 2023-06-01 20:00

import irvine.oeis.recur.GeneratingFunctionSequence;

/**
 * A363350 Number of n element multisets of length 4 vectors over GF(2) that sum to zero.
 * @author Georg Fischer
 */
public class A363350 extends GeneratingFunctionSequence {

  /** Construct the sequence. */
  public A363350() {
    super(0, "[1,-7,28,-49,70,-49,28,-7,1]", "[1,-8,20,8,-126,168,196,-680,239,1072,-1240,-560,1820,-560,-1240,1072,239,-680,196,168,-126,8,20,-8,1]");
  }
}