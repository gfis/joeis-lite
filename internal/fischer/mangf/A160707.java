package irvine.oeis.a160;

import irvine.math.z.Z;
import irvine.oeis.SkipSequence;
import irvine.oeis.transform.RootSequence;
import irvine.oeis.a005.A005130;

/**
 * A160707 Convolution square root of the Robbins sequence, A005130, starting with offset 1.
 * @author Georg Fischer
 */
public class A160707 extends RootSequence {

  /** Construct the sequence. */
  public A160707() {
    super(1, new SkipSequence(new A005130(), 2), 1, 2);
  }
}
