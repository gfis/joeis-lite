package irvine.oeis.a083;
// manually 2021-01-24

import irvine.oeis.GeneratingFunctionSequence;

/**
 * A083024 Molien series for action of SL(3,C) on ternary forms of degree 4.
 * @author Georg Fischer
 */
public class A083024 extends GeneratingFunctionSequence {

  /** Construct the sequence. */
  public A083024() {
    super(0, "[1,0,0,1,1,1,2,3,2,3,4,3,4,4,3,4,3,2,3,2,1,1,0,0,0,1]",
        "[1,-1,-1,0,0,1,0,2,0,-2,0,0,-1,0,1,0,-1,0,1,0,0,2,0,-2,0,-1,0,0,1,1,-1]");
  }
}
