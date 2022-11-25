package irvine.oeis.a276;

import irvine.math.z.Z;
import irvine.oeis.a089.A089910;
import irvine.oeis.PrependSequence;

/**
 * A276885 Sums-complement of the Beatty sequence for 1 + phi.
 * @author Georg Fischer
 */
public class A276885 extends PrependSequence {

  /** Construct the sequence. */
  public A276885() {
    super(0, new A089910(), 1);
  }
}
