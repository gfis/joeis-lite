package irvine.oeis.a227;
// Generated by gen_seq4.pl simple3 at 2023-03-24 09:26

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a227.A227153;

/**
 * A227191 a(n) = n minus (product of nonzero digits in factorial base representation of n).
 * @author Georg Fischer
 */
public class A227191 extends AbstractSequence {

  private int mN = 0;
  private final A227153 mSeq = new A227153();

  /** Construct the sequence. */
  public A227191() {
    super(1);
    mSeq.next();
  }

  @Override
  public Z next() {
    ++mN;
    return Z.valueOf(mN).subtract(mSeq.next());
  }
}