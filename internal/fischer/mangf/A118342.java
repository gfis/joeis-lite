package irvine.oeis.a118;

import irvine.oeis.SkipSequence;
import irvine.oeis.a108.A108447;
import irvine.oeis.transform.RootSequence;

/**
 * A118342 Self-convolution cube of A108447.
 * @author Georg Fischer
 */
public class A118342 extends RootSequence {

  /** Construct the sequence. */
  public A118342() {
    super(0, new SkipSequence(new A108447(), 1), 3, 1);
  }
}
