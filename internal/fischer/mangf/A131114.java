package irvine.oeis.a131;
// Generated by gen_seq4.pl trisumm/trisum2 at 2023-06-07 21:43

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a007.A007318;
import irvine.oeis.a023.A023531;

/**
 * A131114 T(n,k) = 6*binomial(n,k) - 5*I(n,k), where I is the identity matrix; triangle T read by rows (n &gt;= 0 and 0 &lt;= k &lt;= n).
 * @author Georg Fischer
 */
public class A131114 extends AbstractSequence {

  private final long mFactor1 = 6;
  private final long mFactor2 = -5;
  private final A007318 mSeq1 = new A007318();
  private final A023531 mSeq2 = new A023531();

  /** Construct the sequence. */
  public A131114() {
    super(0);
  }

  @Override
  public Z next() {
    return mSeq1.next().multiply(mFactor1).add(mSeq2.next().multiply(mFactor2));
  }
}
