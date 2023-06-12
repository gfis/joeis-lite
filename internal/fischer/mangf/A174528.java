package irvine.oeis.a174;
// Generated by gen_seq4.pl trisumm/trisum2 at 2023-06-07 21:43

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a007.A007318;
import irvine.oeis.a022.A022168;

/**
 * A174528 Triangle T(n,m) = 2*A022168(n,m) - binomial(n, m), 0 &lt;= m &lt;= n, read by rows.
 * @author Georg Fischer
 */
public class A174528 extends AbstractSequence {

  private final long mFactor1 = 2;
  private final long mFactor2 = -1;
  private final A022168 mSeq1 = new A022168();
  private final A007318 mSeq2 = new A007318();

  /** Construct the sequence. */
  public A174528() {
    super(0);
  }

  @Override
  public Z next() {
    return mSeq1.next().multiply(mFactor1).add(mSeq2.next().multiply(mFactor2));
  }
}
