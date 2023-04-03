package irvine.oeis.a108;
// Generated by gen_seq4.pl simple3 at 2023-03-24 09:26

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a061.A061602;

/**
 * A108911 Difference between n and the sum of the factorials of its digits.
 * @author Georg Fischer
 */
public class A108911 extends AbstractSequence {

  private int mN = 0;
  private final A061602 mSeq = new A061602();

  /** Construct the sequence. */
  public A108911() {
    super(1);
    mSeq.next();
  }

  @Override
  public Z next() {
    ++mN;
    return Z.valueOf(mN).subtract(mSeq.next());
  }
}
