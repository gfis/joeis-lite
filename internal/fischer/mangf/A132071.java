package irvine.oeis.a132;
// Generated by gen_seq4.pl trisum/trisum3 at 2023-06-07 16:03

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a002.A002024;
import irvine.oeis.a007.A007318;
import irvine.oeis.a103.A103451;

/**
 * A132071 A007318 + A002024 - A103451 as infinite lower triangular matrices.
 * @author Georg Fischer
 */
public class A132071 extends AbstractSequence {

  private final long mFactor1 = 1;
  private final long mFactor2 = +1;
  private final long mFactor3 = -1;
  private final A007318 mSeq1 = new A007318();
  private final A002024 mSeq2 = new A002024();
  private final A103451 mSeq3 = new A103451();

  /** Construct the sequence. */
  public A132071() {
    super(0);
  }

  @Override
  public Z next() {
    return mSeq1.next().multiply(mFactor1).add(mSeq2.next().multiply(mFactor2)).add(mSeq3.next().multiply(mFactor3));
  }
}
