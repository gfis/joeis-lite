package irvine.oeis.a316;
// Generated by gen_seq4.pl morfps at 2021-05-27 23:03

import irvine.oeis.base.MorphismFixedPointSequence;

/**
 * A316826 Image of 3 under repeated application of the morphism 3 -&gt; 3,2, 2 -&gt; 1,0,2,0,1,2, 1 -&gt; 1,0,1,2, 0 -&gt; 0,2.
 * @author Georg Fischer
 */
public class A316826 extends MorphismFixedPointSequence {

  /** Construct the sequence. */
  public A316826() {
    super(0, "3", "3210", "3->32, 2->102012, 1->1012, 0->02");
  }
}