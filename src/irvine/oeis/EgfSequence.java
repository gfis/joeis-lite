package irvine.oeis;

import irvine.math.z.Z;

/**
 * Wrapper class used by <code>PolynomialFieldSequence</code> to wrap a sequence
 * which is to be treated as an exponential generating function.
 * The target sequence always gets offset 0, and for source offset &gt; 0
 * some zeros are prepended, while for source offset &lt; 0, some terms are skipped.
 * @author Georg Fischer
 */
public class EgfSequence implements Sequence {
  
  private int mN;
  private int mOffset;
  private final Sequence mSeq;

  public EgfSequence(final Sequence seq) {
    // super(); // force offset=0
    mN = -1; 
    mOffset = seq.getOffset();
    mSeq = seq;
    while (mOffset < 0) {
      mSeq.next();
      ++mOffset;
    }
  }

  @Override
  public int getOffset() {
    return 0;
  }

  @Override
  public Z next() {
    ++mN;
    return mN < mOffset ? Z.ZERO : mSeq.next();
  }

  @Override
  public Sequence skip(final long terms) {
    if (terms < 0) {
      throw new IllegalArgumentException();
    }
    for (long k = 0; k < terms; ++k) {
      if (mSeq.next() == null) {
        return mSeq;
      }
    }
    return mSeq;
  }

  @Override
  public Sequence skip() {
    return skip(1);
  }

  public static EgfSequence wrap(final Sequence seq) {
    return new EgfSequence(seq);
  }

}

