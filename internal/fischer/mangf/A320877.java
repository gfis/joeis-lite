package irvine.oeis.a320;
// Generated by gen_seq4.pl seqop at 2023-06-02 22:45

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a076.A076793;

/**
 * A320877 a(n) = 1 + Sum_{k=1..n} 2^prime(k).
 * @author Georg Fischer
 */
public class A320877 extends AbstractSequence {

  private int mN = -1;
  private final A076793 mSeq = new A076793();

  /** Construct the sequence. */
  public A320877() {
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