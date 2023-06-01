package irvine.oeis.a351;
// Generated by gen_seq4.pl holgrep/holos at 2023-05-08 18:43

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A351767 Expansion of e.g.f. exp( x/(1-x)^3 ) / (1-x)^3.
 * @author Georg Fischer
 */
public class A351767 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A351767() {
    super(0, "[[0],[-6,17,-17,7,-1],[-6,17,-15,4],[-5,11,-6],[0,4],[-1]]", "1,4,25,214,2293,29176,427189,7049890,129178249,2597880268", 0);
  }
}