package irvine.oeis.a131;
// Generated by gen_seq4.pl trisum/trisum3 at 2023-06-07 16:03

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a007.A007318;
import irvine.oeis.a065.A065941;
import irvine.oeis.a168.A168561;

/**
 * A131376 A007318 + A065941 - A168561.
 * @author Georg Fischer
 */
public class A131376 extends AbstractSequence {

  private final long mFactor1 = 1;
  private final long mFactor2 = +1;
  private final long mFactor3 = -1;
  private final A007318 mSeq1 = new A007318();
  private final A065941 mSeq2 = new A065941();
  private final A168561 mSeq3 = new A168561();

  /** Construct the sequence. */
  public A131376() {
    super(0);
  }

  @Override
  public Z next() {
    return mSeq1.next().multiply(mFactor1).add(mSeq2.next().multiply(mFactor2)).add(mSeq3.next().multiply(mFactor3));
  }
}