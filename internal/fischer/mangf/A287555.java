package irvine.oeis.a287;
// manually posins at 2021-09-23 21:28

import irvine.oeis.PositionSequence;
import irvine.oeis.a053.A053839;

/**
 * A287555 Positions of 3 in A053839.
 * @author Georg Fischer
 */
public class A287555 extends PositionSequence {

  /** Construct the sequence. */
  public A287555() {
    super(1, new A053839(), 3);
  }
}
