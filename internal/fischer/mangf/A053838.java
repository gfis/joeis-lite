package irvine.oeis.a053;
// Generated by gen_seq4.pl morfps at 2021-09-20 11:24

import irvine.oeis.base.MorphismFixedPointSequence;

/**
 * A053838 a(n) = (sum of digits of n written in base 3) modulo 3.
 * @author Georg Fischer
 */
public class A053838 extends MorphismFixedPointSequence {

  /** Construct the sequence. */
  public A053838() {
    super(0, "0", "0121", "0->012, 1->120, 2->201");
  }
}
