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
 * Often that condition is violated only be a few leading terms, in which case
 * the monotony can be achieved with the <code>.skip(), .prepend(), .adjust()</code> suffixes.
 * @author Georg Fischer
 */
public class SetOperator extends AbstractSequence {

  private final Sequence mSeqA;
  private final Sequence mSeqB;
  private Z mA;
  private Z mB;
  private int mOperation;
  /** Intersection of two sets */
  public static final int INTERSECT = 1;
  /** Set difference */
  public static final int MINUS = 2;
  /** Union of two sets */
  public static final int UNION = 3;

  /**
   * Complement of a sequence.
   * @param offset first index of target sequence
   * @param operation one of INTERSECT, MINUS, UNION
   * @param seqA first sequence
   * @param seqB second sequence
   */
  public SetOperator(final int offset, final int operation, final Sequence seqA, final Sequence seqB) {
    super(offset);
    mOperation = operation;
    mSeqA = seqA;
    mA = mSeqA.next();
    mSeqB = seqB;
    mB = mSeqB.next();
  }

  @Override
  public Z next() {
    Z result = null;
    while (true) {
      int cmp = mA.compareTo(mB);
      switch (mOperation) {
        case INTERSECT:
          switch (cmp) {
            default:
            case -1:
              mA = mSeqA.next();
              break;
            case 0:
              result = mA;
              mA = mSeqA.next();
              return mA;
            case 1:
              mB = mSeqB.next();
              break;
          }
          break;
        default:
        case MINUS:
          switch (cmp) {
            default:
            case -1:
              mA = mSeqA.next();
              break;
            case 0:
              result = mA;
              mA = mSeqA.next();
              return mA;
            case 1:
              mB = mSeqB.next();
              break;
          }
          break;
        case UNION:
          switch (cmp) {
            default:
            case -1:
              mA = mSeqA.next();
              break;
            case 0:
              result = mA;
              mA = mSeqA.next();
              return mA;
            case 1:
              mB = mSeqB.next();
              break;
          }
          break;
      }
    }
  }
}
