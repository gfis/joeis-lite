package irvine.oeis.a187;

import irvine.math.z.Z;
import irvine.oeis.SkipSequence;
import irvine.oeis.transform.RootSequence;
import irvine.oeis.a007.A007820;

/**
 * A187655 Self-convolution of the central Stirling numbers of the second kind.
 * @author Georg Fischer
 */
public class A187655 extends RootSequence {

  /** Construct the sequence. */
  public A187655() {
    super(0, new SkipSequence(new A007820(), 1), 2, 1);
  }
}
