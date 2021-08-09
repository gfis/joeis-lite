package irvine.oeis.a059;

import irvine.math.z.Z;
import irvine.oeis.a000.A000142;
import irvine.oeis.RevertTransformSequence;

/**
 * A059372 Revert transform of factorials.
 * @author Georg Fischer
 */

public class A059372 extends RevertTransformSequence {
  
  /** Construct the sequence */
  public A059372() {
    super(new A000142());
    mSeq.next();
  }
}
