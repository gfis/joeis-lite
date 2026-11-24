package irvine.oeis;

import irvine.math.z.Z;
import irvine.oeis.a000.A000027;
import irvine.oeis.a001.A001477;

/**
 * Operate on two or more sequences as sets 
 * and return the result of the set operation as the target sequence.
 * <ul>
 * <li>A = B u C = B union C</li>
 * <li>A = B x C = B intersection C</li>
 * <li>A = B - C = B minus C (set difference, complement of C with respect to B)</li>
 * </ul>
 * All involved sequences must be monotone (weakly increasing).
 * Often that condition is violated only be a few leading terms, in which case
 * the monotony can be achieved with the <code>.skip(), .prepend(), .adjust()</code> method suffixes.
 * @author Georg Fischer
 */
public class SetOperator extends AbstractSequence {

  private final Sequence[] mSeqs;
  private Z[] mTerms;
  private int mOperation;
  /** Code for the intersection of two sets */
  public static final int INTERSECT = 1;
  /** Code for the set difference */
  public static final int MINUS = 2;
  /** Code for the union of two sets */
  public static final int UNION = 3;

  /**
   * Perform one set operation.
   * @param offset first index of target sequence
   * @param setExpression Strings "B-C" = "B/C", "B+C", "B*C" and so on.
   * @param seqList list of sequences
   */
  public SetOperator(final int offset, final String setExpression, final Sequence... seqList) {
    super(offset);
    switch (setExpression.replaceAll(" ", "").toUpperCase()) {
      case "B*C":
      case "BXC":
        mOperation = INTERSECT;
        break;
      default:
      case "B-C":
      case "B/C":
        mOperation = MINUS;
        break;
      case "B+C":
      case "BUC":
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
   * @param ib index of first sequence
   * @param ic index of second sequence
   * @return next element in target sequence
   */
  private Z step(final int operation, final int ib, final int ic) {
    Z result = null;
    while (true) {
      int cmp = mTerms[ib].compareTo(mTerms[ic]);
      switch (operation) {
        case INTERSECT:
          switch (cmp) {
            default:
            case -1:
              mTerms[ib] = mSeqs[ib].next();
              break;
            case 0:
              result = mTerms[ib];
              mTerms[ib] = mSeqs[ib].next();
              return result;
            case 1:
              mTerms[ic] = mSeqs[ic].next();
              break;
          }
          break;
        default:
        case MINUS:
          // System.out.println("cmp=" + cmp + ", B=mTerms[" + ib + "]=" + mTerms[ib] + ", C=mTerms[" + ic + "]=" + mTerms[ic]);
          switch (cmp) {
            default:
            case -1:
              result = mTerms[ib];
              do {
                mTerms[ib] = mSeqs[ib].next();
              } while (mTerms[ib].equals(result));
              return result;
            case 0:
              mTerms[ib] = mSeqs[ib].next();
              mTerms[ic] = mSeqs[ic].next();
              break;
            case 1:
              mTerms[ic] = mSeqs[ic].next();
              break;
          }
          break;
        case UNION:
          switch (cmp) {
            default:
            case -1:
              result = mTerms[ib];
              mTerms[ib] = mSeqs[ib].next();
              return result;
            case 0:
              result = mTerms[ib];
              mTerms[ib] = mSeqs[ib].next();
              mTerms[ic] = mSeqs[ic].next();
              return result;
            case 1:
              result = mTerms[ic];
              mTerms[ic] = mSeqs[ic].next();
              return result;
          }
      }
    }
  }

  @Override
  public Z next() {
    return step(mOperation, 0, 1);
  }
}
