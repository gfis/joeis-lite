package irvine.oeis.a132;
// Generated by gen_seq4.pl trisum/trisum3 at 2023-06-07 16:03

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a000.A000012;
import irvine.oeis.a001.A001263;
import irvine.oeis.a007.A007318;

/**
 * A132789 Triangle read by rows: T(n,k) = A007318(n-1, k-1) + A001263(n, k) - 1.
 * @author Georg Fischer
 */
public class A132789 extends AbstractSequence {

  private final long mFactor1 = 1;
  private final long mFactor2 = +1;
  private final long mFactor3 = -1;
  private final A007318 mSeq1 = new A007318();
  private final A001263 mSeq2 = new A001263();
  private final A000012 mSeq3 = new A000012();

  /** Construct the sequence. */
  public A132789() {
    super(1);
  }

  @Override
  public Z next() {
    return mSeq1.next().multiply(mFactor1).add(mSeq2.next().multiply(mFactor2)).add(mSeq3.next().multiply(mFactor3));
  }
}
