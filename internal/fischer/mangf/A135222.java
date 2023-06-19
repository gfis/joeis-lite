package irvine.oeis.a135;
// Generated by gen_seq4.pl trisumm/trisum3 at 2023-06-07 16:04

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a000.A000012;
import irvine.oeis.a023.A023531;
import irvine.oeis.a168.A168561;

/**
 * A135222 Triangle A049310 + A000012 - I, read by rows.
 * @author Georg Fischer
 */
public class A135222 extends AbstractSequence {

  private final long mFactor1 = 1;
  private final long mFactor2 = 1;
  private final long mFactor3 = -1;
  private final A168561 mSeq1 = new A168561();
  private final A000012 mSeq2 = new A000012();
  private final A023531 mSeq3 = new A023531();

  /** Construct the sequence. */
  public A135222() {
    super(0);
  }

  @Override
  public Z next() {
    return mSeq1.next().multiply(mFactor1).add(mSeq2.next().multiply(mFactor2)).add(mSeq3.next().multiply(mFactor3));
  }
}