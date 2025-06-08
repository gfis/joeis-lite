package irvine.oeis;

import irvine.math.z.Z;

/**
 * Wrapper class used by <code>PolynomialFieldSequence</code> to wrap a sequence
 * which is to be treated as an exponential generating function.
 * The target sequence always gets offset 0, and for source offset &gt; 0
 * some zeros are prepended, while for source offset &lt; 0, some terms are skipped.
 * @author Georg Fischer
 */
public class EgfWrapper implements Sequence {
  
  private int mN;
  private int mOffset;
  private final Sequence mSeq;

  public EgfWrapper(final Sequence seq) {
    // super(); // force offset=0
    mOffset = seq.getOffset(); 
    mSeq = seq;
/*
    mN = mOffset - 1;
    while (mOffset < 0) {
      ++mN;
      mSeq.next();
      ++mOffset;
    }
*/
  }

  @Override
  public int getOffset() {
    return mOffset;
  }

  @Override
  public Z next() {
    // ++mN;
    // return mN < mOffset ? Z.ZERO : mSeq.next();
    return mSeq.next();
  }

  @Override
  public Sequence skip(final long terms) {
    if (terms < 0) {
      throw new IllegalArgumentException();
    }
    for (long k = 0; k < terms; ++k) { 
      ++mN;
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

  /**
   * Reflective method for the underlying sequence.
   * @return the underlying sequence
   */
  public Sequence getSequence() {
    return mSeq;
  }

  public static EgfWrapper wrap(final Sequence seq) {
    return new EgfWrapper(seq);
  }

}

