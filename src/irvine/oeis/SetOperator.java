package irvine.oeis;

import irvine.math.z.Z;
import irvine.oeis.a000.A000027;
import irvine.oeis.a001.A001477;

/**
 * Set operations on sequences: 
 * <ul>
 * <li>A union B</li>
 * <li>A intersection B</li>
 * <li>A minus B, set difference</li>, complement of B with respect to A</li>
 * </ul>
 * All involved sequences must be monotone (weakly increasing).
 * Often that condition is violated only be a few leading terms, in which case
 * the monotony can be achieved with the <code>.skip(), .prepend(), .adjust()</code> suffixes.
 * @author Georg Fischer
 */
public class SetOperator extends AbstractSequence {

  private final Sequence[] mSeqs;
  private Z[] mTerms;
  private int mOperation;
  /** Intersection of two sets */
  public static final int INTERSECT = 1;
  /** Set difference */
  public static final int MINUS = 2;
  /** Union of two sets */
  public static final int UNION = 3;

  /** natural numbers: 1, 2, 3 etc. */
  public static final Sequence N = new A000027();
  /** nonegative numbers: 0, 1, 2, 3 etc. */
  public static final Sequence N0 = new A001477();

  /**
   * Complement of a sequence.
   * @param offset first index of target sequence
   * @param setExpression "B-C" = "B/C", "B+C", "B*C" and so on.
   * @param seqList list of sequences
   */
  public SetOperator(final int offset, final String setExpression, final Sequence... seqList) {
    super(offset);
    switch (setExpression) {
      case "B*C":
      case "BxC":
        mOperation = INTERSECT;
        break;
      default:
      case "B-C":
      case "B/C":
        mOperation = MINUS;
        break;
      case "B+C":
      case "BuC":
        mOperation = UNION;
        break;
    }
    final int slen = seqList.length;
    mSeqs = new Sequence[slen];
    mTerms = new Z[slen];
    for (int i = 0; i < slen; ++i) {
      mSeqs[i] = seqList[i];
      mTerms[i] = mSeqs[i].next();
    }
  }

  /**
   * Computes the next element of the target set.
   * @param operation operation to be performed: INTERSECT, MINUS, UNION.
   * @param ia index of first sequence
   * @param ib index of second sequence
   * @return next element in target sequence
   */
  private Z step(final int operation, final int ia, final int ib) {
    Z result = null;
    while (true) {
      int cmp = mTerms[ia].compareTo(mTerms[ib]);
      switch (operation) {
        case INTERSECT:
          switch (cmp) {
            default:
            case -1:
              mTerms[ia] = mSeqs[ia].next();
              break;
            case 0:
              result = mTerms[ia];
              mTerms[ia] = mSeqs[ia].next();
              return mTerms[ia];
            case 1:
              mTerms[ib] = mSeqs[ib].next();
              break;
          }
          break;
        default:
        case MINUS:
          switch (cmp) {
            default:
            case -1:
              mTerms[ia] = mSeqs[ia].next();
              break;
            case 0:
              result = mTerms[ia];
              mTerms[ia] = mSeqs[ia].next();
              return mTerms[ia];
            case 1:
              mTerms[ib] = mSeqs[ib].next();
              break;
          }
          break;
        case UNION:
          switch (cmp) {
            default:
            case -1:
              mTerms[ia] = mSeqs[ia].next();
              break;
            case 0:
              result = mTerms[ia];
              mTerms[ia] = mSeqs[ia].next();
              return mTerms[ia];
            case 1:
              mTerms[ib] = mSeqs[ib].next();
              break;
          }
          break;
      }
    }
  }

  @Override
  public Z next() {
  	return step(mOperation, 0, 1);
  }
}
