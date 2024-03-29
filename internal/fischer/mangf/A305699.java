package irvine.oeis.a305;

import irvine.math.z.Z;
import irvine.oeis.SkipSequence;
import irvine.oeis.a014.A014708;
import irvine.oeis.transform.RootSequence;


/**
 * A305699 Coefficients of 1/(q*(j(q)-744)) where j(q) is the elliptic modular invariant.
 * @author Georg Fischer
 */
public class A305699 extends RootSequence {

  /** Construct the sequence. */
  public A305699() {
    super(0, new SkipSequence(new A014708(), 1), -1, 1);
  }
}
