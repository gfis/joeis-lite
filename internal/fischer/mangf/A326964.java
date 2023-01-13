package irvine.oeis.a326;
// manually trafo

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a323.A323818;
import irvine.oeis.transform.BinomialTransformSequence;

/**
 * A326964 Number of connected set-systems covering a subset of {1..n}.
 * @author Georg Fischer
 */
public class A326964 extends AbstractSequence {

  private final BinomialTransformSequence mSeq1 = new BinomialTransformSequence(new A323818(),0);

  /** Construct the sequence. */
  public A326964() {
    super(0);
  }

  @Override
  public Z next() {
    return mSeq1.next();
  }
}
