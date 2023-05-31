package irvine.oeis.a350;

import irvine.math.z.Z;
import irvine.oeis.SkipSequence;
import irvine.oeis.transform.RootSequence;
import irvine.oeis.a023.A023887;

/**
 * A350503 Self-convolution of sigma_n(n).
 * @author Georg Fischer
 */
public class A350503 extends RootSequence {

  /** Construct the sequence. */
  public A350503() {
    super(1, new SkipSequence(new A023887(), 1), 2, 1);
  }
}
