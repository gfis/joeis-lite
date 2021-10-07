package irvine.oeis;

import irvine.math.z.Z;
import irvine.math.z.ZUtils;

/**
 * Generate the rows of a triangle T(n,k) depending on
 * the left and right border (column), and the terms in the previous rows.
 * This generalizes the rules for Pascal's triangle (A007318):
 * T(n,0) = T(n,n) = 1 and T(n,k) = T(n-1,k-1) + T(n-1,k) for 0 &lt; k &lt; n.
 * @author Georg Fischer
 */
public class WrappedTriangleRecurrence extends TriangleRecurrence {

  private final Sequence mSeqLeft; // sequence for the left border T(n,0)
  private final Sequence mSeqRight; // sequence for the right border T(n,n); this overwrites T(0,0)
  private Sequence mSeqPlus; // a(n) of this optional sequence may be used to compute T(n,k) for 0 &lt; k &lt; n.
  private Z mPlus; // term of mSeqPlus, additive constant per row

  /**
   * A simple version of <code>PaddingSequence</code>:
   * Return a few terms and repeat the last one forever.
   */
  protected class BorderSequence implements Sequence {

    private Z[] mTerms;
    private int mN;
    private int mLen;

    /** Construct the sequence. */
    protected BorderSequence(final String terms) {
      mTerms = ZUtils.toZ(terms);
      mLen = mTerms.length - 1;
      mN = -1;
    }

    @Override
    public Z next() {
      if (mN < mLen) {
        ++mN;
      }
      return mTerms[mN];
    }
  }

  /**
   * Empty constructor.
   * Generates an ordinary Pascal triangle.
   */
  public WrappedTriangleRecurrence() {
    mSeqLeft = new BorderSequence("1");
    mSeqRight = new BorderSequence("1");
    initialize();
  }

  /**
   * Triangle with two sequences for the borders.
   * @param seqLeft sequence for the left border T(n,0)
   * @param seqRight sequence for the right border T(n,n); this overwrites T(0,0)
   */
  public WrappedTriangleRecurrence(final Sequence seqLeft, final Sequence seqRight) {
    mSeqLeft = seqLeft;
    mSeqRight = seqRight;
    initialize();
  }

  /**
   * Triangle with a sequence and a value for the borders.
   * @param seqLeft sequence for the left border T(n,0)
   * @param valRight constant right border T(n,n); this overwrites T(0,0)
   */
  public WrappedTriangleRecurrence(final Sequence seqLeft, final String valRight) {
    mSeqLeft = seqLeft;
    mSeqRight = new BorderSequence(valRight);
    initialize();
  }

  /**
   * Triangle with a value and a sequence for the borders.
   * @param valLeft constant left border T(n,0)
   * @param seqRight sequence for the right border T(n,n); this overwrites T(0,0)
   */
  public WrappedTriangleRecurrence(final String valLeft, final Sequence seqRight) {
    mSeqLeft = new BorderSequence(valLeft);
    mSeqRight = seqRight;
    initialize();
  }

  /**
   * Triangle with two values for the borders.
   * @param valLeft constant left border T(n,0)
   * @param valRight constant right border T(n,n); this overwrites T(0,0)
   */
  public WrappedTriangleRecurrence(final String valLeft, final String valRight) {
    mSeqLeft = new BorderSequence(valLeft);
    mSeqRight = new BorderSequence(valRight);
    initialize();
  }

  /**
   * Initializes the data structure.
   * Collects the code that is common to all constructors.
   * Assumes that there is no additional term.
   */
  private void initialize() {
    mSeqPlus = null;
    mPlus = Z.ZERO;  // for safety
  }

  /**
   * Sets the sequence for the additive term
   * @param terms the constant value to be added to each element.
   */
  protected void setPlus(final String terms) {
    mSeqPlus = new BorderSequence(terms);
  }

  /**
   * Sets the sequence for the additive term
   * @param seqPlus sequence that returns the constant value to be added to each element.
   */
  protected void setPlus(final Sequence seqPlus) {
    mSeqPlus = seqPlus;;
  }

  /**
   * Gets the additive term from mSeqPlus for the current row
   * @return mPlus
   */
  protected Z getPlus() {
    return mPlus;
  }

  /**
   * Advances the sequence for the leftmost column.
   * @param skip number of elements to skip
   */
  protected void skipLeft(int skip) {
    while (skip > 0) {
      mSeqLeft.next();
      --skip;
    }
  }

  /**
   * Advances the sequence for the rightmost column.
   * @param skip number of elements to skip
   */
  protected void skipRight(int skip) {
    while (skip > 0) {
      mSeqRight.next();
      --skip;
    }
  }

  /**
   * Advances the sequence for the additive term.
   * @param skip number of elements to skip
   */
  protected void skipPlus(int skip) {
    while (skip > 0) {
      mSeqPlus.next();
      --skip;
    }
  }

  /**
   * Increases the row index, adds a new, empty row and resets the column index.
   */
  protected void addRow() {
    super.addRow();
    set(0, mSeqLeft.next());
    set(mN, mSeqRight.next());
    if (mSeqPlus != null) {
      mPlus = mSeqPlus.next();
    }
  }

  /**
   * Computes an element of the triangle.
   * The default implementation here is Pascal's rule.
   * @param n row number
   * @param k column number
   * @return T(n,k)
   */
  protected Z compute(final Integer n, final Integer k) {
    Z result = null;
    if (k < 0 || k > n) { // outside, for safety only
      result = Z.ZERO;
    } else if (k == 0 || k == n) { 
      result = get(n, k); // borders were already set in addRow
    } else {
      result = get(n - 1, k - 1).add(get(n - 1, k)); // Pascal's rule
      if (mSeqPlus != null) {
        result = result.add(mPlus);
      }
    }
    return result;
  }

  /**
   * Main method: debugging output of a triangle.
   * @param args command line arguments:
   * <ul>
   * <li>left constant or sequence</li>
   * <li>right constant or sequence</li>
   * <li>additional constant or sequence (optional)</li>
   * <li>number of rows to be printed (optional)</li>
   * </ul>
   */
  public static void main(String[] args) {
    Sequence seqLeft = null;
    Sequence seqRight = null;
    Sequence seqPlus = null;
    String valLeft = "1";
    String valRight = "1";
    String valPlus = null;
    int noRows = 8;
    for (int iarg = 0; iarg < args.length; ++iarg) {
      switch (iarg) {
        default:
        case 0:
          valLeft = args[iarg];
          break;
        case 1:
          valRight = args[iarg];
          break;
        case 2:
          valPlus = args[iarg];
          break;
        case 3:
          try {
            noRows = Integer.parseInt(args[iarg]);
          } catch (Exception exc) { // take default
          }
          break;
      }
    }
    WrappedTriangleRecurrence wtr = null;
    if (valLeft.startsWith("A")) {
      seqLeft = irvine.test.SequenceTest.sequence(valLeft);
      if (valRight.startsWith("A")) {
        seqRight = irvine.test.SequenceTest.sequence(valRight);
        wtr = new WrappedTriangleRecurrence(seqLeft, seqRight);
      } else {
        wtr = new WrappedTriangleRecurrence(seqLeft, valRight);
      }
    } else {
      if (valRight.startsWith("A")) {
        seqRight = irvine.test.SequenceTest.sequence(valRight);
        wtr = new WrappedTriangleRecurrence(valLeft, seqRight);
      } else {
        wtr = new WrappedTriangleRecurrence(valLeft, valRight);
      }
    }
    if (valPlus != null) {
      if (valPlus.startsWith("A")) {
        seqPlus = irvine.test.SequenceTest.sequence(valLeft);
        wtr.setPlus(seqPlus);
      } else {
        wtr.setPlus(valPlus);
      }
    }
    for (int n = 0; n < noRows; ++n) {
      for (int k = 0; k <= n; ++k) {
        final Z term = wtr.next();
      }
      wtr.printRow(n);
    }
  }
}