package irvine.oeis.a131;
// Generated by gen_seq4.pl trisum/trisum2 at 2023-06-07 16:03

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a128.A128174;
import irvine.oeis.a131.A131821;

/**
 * A131911 2*A131821 - A128174.
 * @author Georg Fischer
 */
public class A131911 extends AbstractSequence {

  private final long mFactor1 = 2;
  private final long mFactor2 = -1;
  private final A131821 mSeq1 = new A131821();
  private final A128174 mSeq2 = new A128174();

  /** Construct the sequence. */
  public A131911() {
    super(1);
  }

  @Override
  public Z next() {
    return mSeq1.next().multiply(mFactor1).add(mSeq2.next().multiply(mFactor2));
  }
}
