package irvine.oeis;

import irvine.math.z.Z;

/**
 * Wrapper class used by <code>PolynomialFieldSequence</code> to wrap a sequence
 * which is to be treated as an exponential generating function.
 * @author Georg Fischer
 */
public class EgfWrapper implements Sequence {
  
  private int mOffset;
  private final Sequence mSeq;

  public EgfWrapper(final Sequence seq) {
    mOffset = seq.getOffset(); 
    mSeq = seq;
  }

  @Override
  public int getOffset() {
    return mOffset;
  }

  @Override
  public Z next() {
    return mSeq.next();
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

  /**
   * Wrap method used by <code>PolynomialFieldSequence</code>.
   * @param seq sequence to be treated as exponential generating function
   * @return resulting instance that can be tested with <code>instanceof EgfWrapper</code>
   */
  public static EgfWrapper wrap(final Sequence seq) {
    return new EgfWrapper(seq);
  }

  /**
   * Reflective method for the underlying sequence.
   * @return the underlying sequence
   */
  public Sequence getSequence() {
    return mSeq;
  }

}

