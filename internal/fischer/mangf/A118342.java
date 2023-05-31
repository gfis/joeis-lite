package irvine.oeis.a118;

import irvine.math.z.Z;
import irvine.oeis.SkipSequence;
import irvine.oeis.transform.RootSequence;
import irvine.oeis.a108.A108447;

/**
 * A118341 Self-convolution cube of A108447.
 * @author Georg Fischer
 */
public class A118342 extends RootSequence {

  /** Construct the sequence. */
  public A118342() {
    super(1, new SkipSequence(new A108447(), 1), 3, 1);
  }
}
