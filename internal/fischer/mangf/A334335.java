package irvine.oeis.a334;
// manually trafo

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a000.A000568;
import irvine.oeis.transform.InverseEulerTransform;

/**
 * A334335 Inverse Euler transform of A000568.
 * @author Georg Fischer
 */
public class A334335 extends AbstractSequence {

  private final InverseEulerTransform mSeq1 = new InverseEulerTransform(new A000568(),0);

  /** Construct the sequence. */
  public A334335() {
    super(1);
    mSeq1.next();
  }

  @Override
  public Z next() {
    return mSeq1.next();
  }
}
