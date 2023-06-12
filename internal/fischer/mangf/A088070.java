package irvine.oeis.a088;
// Generated by gen_seq4.pl seqop at 2023-06-02 22:45

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a063.A063464;

/**
 * A088070 Numbers sandwiched between two numbers having the same number of prime divisors.
 * @author Georg Fischer
 */
public class A088070 extends AbstractSequence {

  private int mN = 0;
  private final A063464 mSeq = new A063464();

  /** Construct the sequence. */
  public A088070() {
    super(1);
    int bOffset = 1 - 1;
    while (bOffset < mN) {
      ++bOffset;
      mSeq.next();
    }
  }

  @Override
  public Z next() {
    ++mN;
    return mSeq.next().add(1);
  }
}
