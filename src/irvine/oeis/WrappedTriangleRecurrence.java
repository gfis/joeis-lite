package irvine.oeis;

import irvine.math.z.Z;
import irvine.math.MemoryFunction2;

/**
 * Generate the rows of a triangle T(n,k) depending on
 * the left and right border (column), and the terms in the previous rows.
 * This generalizes the rules for Pascal's triangle (A007318):
 * T(n,0) = T(n,n) = 1 and T(n,k) = T(n-1,k-1) + T(n-1,k) for 0 &lt; k &lt; n.
 * n and k always start with 0.
 * @author Georg Fischer
 */
public class WrappedTriangleRecurrence extends MemoryFunction2<Integer, Z> implements Sequence {

  private final Sequence mSeqLeft; // sequence for the left border T(n,0)
  private final Sequence mSeqRight; // sequence for the right border T(n,n); this overwrites T(0,0)
  private Sequence mSeqPlus; // a(n) of this optional sequence may be used to compute T(n,k) for 0 &lt; k &lt; n.
  private Z mPlus; // term of mSeqPlus, additive constant per row
  private int mN; // current row index n
  private int mK; // current column index k

  protected class ConstantSequence implements Sequence {
    
    private Z mValue = Z.ZERO;
    /** Construct the sequence */
    
    protected ConstantSequence(final long value) {
      mValue = Z.valueOf(value);
    }
    
    @Override
    public Z next() {
      return mValue;
    }
  }
    
  /**
   * Empty constructor.
   * Generates an ordinary Pascal triangle.
   */
  public WrappedTriangleRecurrence() {
    mSeqLeft = new ConstantSequence(1);
    mSeqRight = new ConstantSequence(1);
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
  public WrappedTriangleRecurrence(final Sequence seqLeft, final long valRight) {
    mSeqLeft = seqLeft;
    mSeqRight = new ConstantSequence(valRight);
    initialize();
  }

  /**
   * Triangle with a value and a sequence for the borders.
   * @param valLeft constant left border T(n,0)
   * @param seqRight sequence for the right border T(n,n); this overwrites T(0,0)
   */
  public WrappedTriangleRecurrence(final long valLeft, final Sequence seqRight) {
    mSeqLeft = new ConstantSequence(valLeft);
    mSeqRight = seqRight;
    initialize();
  }

  /**
   * Triangle with two values for the borders.
   * @param valLeft constant left border T(n,0)
   * @param valRight constant right border T(n,n); this overwrites T(0,0)
   */
  public WrappedTriangleRecurrence(final long valLeft, final long valRight) {
    mSeqLeft = new ConstantSequence(valLeft);
    mSeqRight = new ConstantSequence(valRight);
    initialize();
  }

  /**
   * Initializes the data structure.
   * Collects the code that is common to all constructors.
   */
  protected void initialize() {
    mSeqPlus = null;
    mPlus = Z.ZERO;  // for safety
    mN = -1;
    mK = 0; // start with first element T(0,0)
  }
  
  /**
   * Computes a triangle element that does not yet exist element.
   * This method is typically overwritten.
   * The default implementation here is Pascal's rule.
   * @param n row number
   * @param k column number
   * @return T(n,k)
   */
  @Override
  protected Z compute(final Integer n, final Integer k) {
    Z result = null;
    if (k < 0 || k > n || n < 0) {
      result = Z.ZERO;
    }
    if (k == 0) { // left border
      result = mSeqLeft.next();
    }
    if (k == n) { // right border (has priority)
      result = mSeqRight.next();
    } else if (k > 0) { // inner element
      result = getElement(n, k);
    }
    return result;
  }

  /**
   * Computes an inner triangle element.
   * This method is typically overwritten.
   * The default implementation here is Pascal's rule.
   * @param n row number
   * @param k column number
   * @return T(n,k)
   */
  protected Z getElement(final Integer n, final Integer k) {
    Z result = get(n - 1, k - 1).add(get(n - 1, k));
    if (mSeqPlus != null) {
      result = result.add(getPlus());
    }
    return result;
  }

  /**
   * Return next term, reading the triangle row by row from left to right, starting with T(0,0).
   * @return the next term of the sequence.
   */
  @Override
  public Z next() {
    if (++mK > mN) {
      ++mN;
      mK = 0;
      if (mSeqPlus != null && mN >= 2) {
        mPlus = mSeqPlus.next();
      }
    }
    return get(mN, mK);
  }
  
  /**
   * Gets the additive term from mSeqPlus for the current row
   * @return mPlus
   */
  protected Z getPlus() {
    return mPlus;
  }

  /**
   * Sets the sequence for the additive term
   * @param value the constant value to be added to each element.
   */
  protected void setPlus(final long value) {
    mSeqPlus = new ConstantSequence(value);
  }

  /**
   * Sets the sequence for the additive term
   * @param seqPlus sequence that returns the constant value to be added to each element.
   */
  protected void setPlus(final Sequence seqPlus) {
    mSeqPlus = seqPlus;;
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
}