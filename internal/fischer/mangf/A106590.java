package irvine.oeis.a106;
// Generated by gen_seq4.pl morfps at 2021-05-27 23:03

import irvine.oeis.base.MorphismFixedPointSequence;

/**
 * A106590 Trajectory of 1 under the morphism 1-&gt;{2}, 2-&gt;{3,3,3}, 3-&gt;{1,2,3}.
 * @author Georg Fischer
 */
public class A106590 extends MorphismFixedPointSequence {

  /** Construct the sequence. */
  public A106590() {
    super(0, "1", "1231", "1->2, 2->333, 3->123");
  }
}
