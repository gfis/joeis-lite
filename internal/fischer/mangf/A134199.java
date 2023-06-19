package irvine.oeis.a134;
// Generated by gen_seq4.pl trisum/trisum3 at 2023-06-10 10:12

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a002.A002260;
import irvine.oeis.a023.A023531;
import irvine.oeis.a134.A134082;

/**
 * A134199 A002260 + A134082 - I as infinite lower triangular matrices; I = Identity matrix.
 * @author Georg Fischer
 */
public class A134199 extends AbstractSequence {

  private final long mFactor1 = 1;
  private final long mFactor2 = +1;
  private final long mFactor3 = -1;
  private final A002260 mSeq1 = new A002260();
  private final A134082 mSeq2 = new A134082();
  private final A023531 mSeq3 = new A023531();

  /** Construct the sequence. */
  public A134199() {
    super(0);
  }

  @Override
  public Z next() {
    return mSeq1.next().multiply(mFactor1).add(mSeq2.next().multiply(mFactor2)).add(mSeq3.next().multiply(mFactor3));
  }
}