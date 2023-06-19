package irvine.oeis.a225;
// Generated by gen_seq4.pl seqop at 2023-06-02 22:45

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a106.A106481;

/**
 * A225373 a(n) = 1 + Sum_{i=0..floor(n/2)} phi(n-2*i).
 * @author Georg Fischer
 */
public class A225373 extends AbstractSequence {

  private int mN = -1;
  private final A106481 mSeq = new A106481();

  /** Construct the sequence. */
  public A225373() {
    super(0);
    int bOffset = 0 - 1;
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