package irvine.oeis.a131;
// Generated by gen_seq4.pl trisumm/trisum2 at 2023-06-07 16:04

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a007.A007318;
import irvine.oeis.a167.A167374;

/**
 * A131127 Table read by rows: 2*A007318(n,m) - (-1)^(n+m)*A097806(n,m).
 * @author Georg Fischer
 */
public class A131127 extends AbstractSequence {

  private final long mFactor1 = 2;
  private final long mFactor2 = -1;
  private final A007318 mSeq1 = new A007318();
  private final A167374 mSeq2 = new A167374();

  /** Construct the sequence. */
  public A131127() {
    super(0);
  }

  @Override
  public Z next() {
    return mSeq1.next().multiply(mFactor1).add(mSeq2.next().multiply(mFactor2));
  }
}
