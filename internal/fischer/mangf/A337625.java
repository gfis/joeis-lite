package irvine.oeis.a337;

import irvine.math.z.Z;
import irvine.oeis.MemorySequence;
import irvine.oeis.Sequence;
import irvine.oeis.SequenceWithOffset;
import irvine.oeis.a000.A000032;
import irvine.oeis.a000.A000045;
import irvine.oeis.a014.A014076;

/**
 * A337625 Odd composite integers m such that F(m)^2 == 1 (mod m) and L(m) == 1 (mod m), where F(m) and L(m) are the m-th Fibonacci and Lucas numbers, respectively.
 * @author Georg Fischer
 */
public class A337625 extends A014076 implements SequenceWithOffset {

  private int mK;
  private int mOffset;
  private MemorySequence mSeq1;
  private int mExp;
  private Z mMod1;
  private MemorySequence mSeq2;
  private Z mMod2;

  /** Construct the sequence. */
  public A337625() {
    this(1, new A000045(), 2, 1, new A000032(), 1);
  }

  /**
   * Generic constructor with parameters
   * @param offset index of first term
   * @param seq1 first underlying sequence
   * @param exp exponent
   * @param mod1 first modulus
   * @param seq2 second underlying sequence
   * @param mod2 second modulus
   */
  public A337625(final int offset, final Sequence seq1, final int exp, final int mod1, final Sequence seq2, final int mod2) {
    super.next(); // skip 1
    mOffset = offset;
    mSeq1 = MemorySequence.cachedSequence(seq1);
    mSeq2 = MemorySequence.cachedSequence(seq2);
    mExp = exp;
    mMod1 = Z.valueOf(mod1);
    mMod2 = Z.valueOf(mod2);
  }

  @Override
  public int getOffset() {
    return mOffset;
  }

  @Override
  public Z next() {
    while (true) {
      final Z m = super.next();
      mK = m.intValueExact();
      Z val = mSeq1.a(mK);
      if (mExp > 1) {
        val = val.pow(mExp);
      }
  //  if (val.mod(m).equals(mMod1) && mSeq2.a(mK).mod(m).equals(mMod2)) {
      if (val.subtract(mMod1).remainder(m).isZero() && mSeq2.a(mK).subtract(mMod2).remainder(m).isZero()) {
        return m;
      }
    }
  }
}
