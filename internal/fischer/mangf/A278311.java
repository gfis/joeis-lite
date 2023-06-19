package irvine.oeis.a278;
// Generated by gen_seq4.pl seqop at 2023-06-02 22:45

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a045.A045939;

/**
 * A278311 Numbers n such that n-1 and n+1 have the same number of prime factors as n (with multiplicity).
 * @author Georg Fischer
 */
public class A278311 extends AbstractSequence {

  private int mN = 0;
  private final A045939 mSeq = new A045939();

  /** Construct the sequence. */
  public A278311() {
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