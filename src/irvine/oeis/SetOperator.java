package irvine.oeis;

import irvine.math.z.Z;

/**
 * Set operations on sequences: 
 * <ul>
 * <li>A union B</li>
 * <li>A intersection B</li>
 * <li>A minus B, set difference</li>
 * <li>complement of A with respect to B</li>
 * </ul>
 * All involved sequences must be monotone (weakly increasing).
 * Often that condition is violeted only be a few leading terms, in which case
 * the monotony can be achieved with the <code>.skip(), .prepend(), .adjust()</code> suffixes.
 * @author Georg Fischer
 */
public class SetOperator extends AbstractSequence {

  private static final int DEFOFF = 1;
  private final Sequence mSeq;
  private Z mN;
  private Z mCurrent;

  /**
   * Complement of a sequence.
   * @param start start value
   * @param seq sequence to complement
   */
  public SetOperator(final Z start, final Sequence seq) {
    this(DEFOFF, start, seq);
  }

  /**
   * Complement of a sequence starting at 0.
   * @param seq sequence to complement
   */
  public SetOperator(final Sequence seq) {
    this(DEFOFF, Z.ZERO, seq);
  }

  /**
   * Complement of a sequence.
   * @param offset first index of target sequence
   * @param start start value
   * @param seq sequence to complement
   */
  public SetOperator(final int offset, final Z start, final Sequence seq) {
    super(offset);
    mSeq = seq;
    mN = start;
    mCurrent = mSeq.next();
  }

  /**
   * Complement of a sequence.
   * @param offset first index of target sequence
   * @param start start value
   * @param seq sequence to complement
   */
  public SetOperator(final int offset, final long start, final Sequence seq) {
    this(offset, Z.valueOf(start), seq);
  }

  /**
   * Complement of a sequence starting at 0.
   * @param offset first index of target sequence
   * @param seq sequence to complement
   */
  public SetOperator(final int offset, final Sequence seq) {
    this(offset, Z.ZERO, seq);
  }

  @Override
  public Z next() {
    while (true) {
      while (mCurrent != null && mCurrent.compareTo(mN) < 0) {
        final Z t = mSeq.next();
        if (t != null && mCurrent.compareTo(t) > 0) {
          throw new UnsupportedOperationException("Underlying sequence is not monotonic increasing");
        }
        mCurrent = t;
      }
      final Z t = mN;
      mN = mN.add(1);
      if (!t.equals(mCurrent)) {
        return t;
      }
    }
  }
}
