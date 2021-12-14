package irvine.oeis.ca;

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * Computes Stephen Wolfram's one-dimensional automaton sequences.
 * @author Pablo Mayrgundter
 * @author Sean A. Irvine
 * @author Georg Fischer
 */
public class Wolfram1DAutomaton implements Sequence {

  private final boolean[] mRule;
  private Z mCur;
  private long mRow;
  private long mCol;
  private int mLength;
  /** Number of the generation */
  protected int mGen;
  /** Current cell number in the triangle, see {@link #next}. */
  protected int mN; //
  /** Summation term for several subtypes of sequences */
  protected Z mSum;
  /** Count of BLACK/ON cells in current row */
  protected int mBlackCount;

  /**
   * Construct a new generator for the specified Wolfram automaton.
   * The automaton is initialized with the <code>startState</code>.
   * @param rule the rule to use
   * @param startState initial state
   * @exception IllegalArgumentException if the rule is not valid.
   */
  public Wolfram1DAutomaton(final int rule, final Z startState) {
    if ((rule & ~0xFF) != 0) {
      throw new IllegalArgumentException("Rule must be 0 <= rule <= 255");
    }
    mRule = new boolean[8];
    mRule[0] = (rule & 1) != 0;
    mRule[1] = (rule & 2) != 0;
    mRule[2] = (rule & 4) != 0;
    mRule[3] = (rule & 8) != 0;
    mRule[4] = (rule & 16) != 0;
    mRule[5] = (rule & 32) != 0;
    mRule[6] = (rule & 64) != 0;
    mRule[7] = (rule & 128) != 0;
    mCur = startState;
    mLength = Math.max(1, startState.bitLength());
    mRow = -1;
    mCol = -1;
    mGen = 0;
    mN = -1;
    mSum = Z.ZERO;
    mBlackCount = startState.bitCount();
  }

  /**
   * Construct a new generator for the specified Wolfram automaton.
   * The automaton is initialized with a single black pixel.
   * @param rule the rule to use
   * @exception IllegalArgumentException if the rule is not valid.
   */
  public Wolfram1DAutomaton(final int rule) {
    this(rule, Z.ONE);
  }

  private boolean isSet(final Z set, final int k) {
    return k < 0 || k >= mLength ? mRow > 1 && mRule[0] : set.testBit(k);
  }

  public Z computeNextRow() {
    if (++mRow == 0) {
      return mCur;
    }
    Z next = Z.ZERO;
    for (int k = 0; k < mLength + 2; ++k) {
      // get left, centre, right pixels
      final int l = isSet(mCur, k - 2) ? 4 : 0;
      final int c = isSet(mCur, k - 1) ? 2 : 0;
      final int r = isSet(mCur, k) ? 1 : 0;
      if (mRule[l | c | r]) {
        next = next.setBit(k);
      }
    }
    mLength += 2;
    ++mRow;
    mCur = next;
    return mCur;
  }

  @Override
  public Z next() {
    return mCur;
  }

  /**
   * Convenience method to return the next state of an automaton.
   * @param rule rule number of the specific automaton
   * @param state starting state
   * @return next sate
   */
  public static Z step(final int rule, final Z state) {
    final Wolfram1DAutomaton a = new Wolfram1DAutomaton(rule, state);
    a.next(); // skip the input state
    return a.next();
  }

  /**
   * Get the number of ON/BLACK cells in the current row.
   * This method is the basis for the methods {@link #nextBlackCount}, {@link #nextBlackSum}, {@link #nextWhiteCount}, {@link #nextWhiteSum}.
   * @return 3 for generation 2 of rule 30 (11001).
   */
  public int getBlackCount() {
    return mCur.bitCount();
  }

  /**
   * Get the next row as a binary number represented by decimal digits.
   * @return 11001 for generation 2 of rule 30.
   */
  public Z nextStageB() {
    ++mN;
    return new Z(new StringBuilder(computeNextRow().toString(2)).reverse());
  }

  /**
   * Get the next row as a decimal number.
   * @return 25 for generation 2 of rule 30.
   */
  public Z nextStageD() {
    ++mN;
    return computeNextRow();
  }

  /**
   * Get the cell in the middle of the next row.
   * @return 0 for generation 2 of rule 30.
   */
  public Z nextMiddle() {
    return computeNextRow().testBit(++mN) ? Z.ONE : Z.ZERO;
  }

  /**
   * Get the center column of the triangle up to generation n as a binary number represented by decimal digits.
   * @return 110 for generation 2 of rule 30.
   */
  public Z nextMiddleB() {
    mSum = mSum.multiply(10).add(computeNextRow().testBit(++mN) ? 1 : 0);
    computeNextRow();
    return mSum;
  }

  /**
   * Get the center column of the triangle up to generation n as a decimal number.
   * @return 6 for generation 2 of rule 30.
   */
  public Z nextMiddleD() {
    mSum = mSum.shiftLeft(1).add(computeNextRow().testBit(++mN) ? 1 : 0);
    computeNextRow();
    return mSum;
  }

  /**
   * Get the number of ON/BLACK cells in the row.
   * @return 3 for generation 2 of rule 30 (11001).
   */
  public Z nextBlackCount() {
    ++mN;
    mSum = Z.valueOf(getBlackCount());
    computeNextRow();
    return mSum;
  }

  /**
   * Get the partial sum of ON/BLACK cells up to row n.
   * @return 7 for generation 2 of rule 30 (1, 111, 11001).
   */
  public Z nextBlackSum() {
    ++mN;
    mSum = mSum.add(getBlackCount());
    computeNextRow();
    return mSum;
  }

  /**
   * Get the number of OFF/WHITE cells in the current row.
   * @return 2 for generation 2 of rule 30 (11001).
   */
  public Z nextWhiteCount() {
    ++mN;
    mSum = Z.valueOf(2 * mGen + 1).subtract(getBlackCount());
    computeNextRow();
    return mSum;
  }

  /**
   * Get the partial sum of OFF/WHITE cells up to row n.
   * @return 2 for generation 2 of rule 30 (1, 111, 11001).
   */
  public Z nextWhiteSum() {
    ++mN;
    mSum = mSum.add(Z.valueOf(2 * mGen + 1).subtract(getBlackCount()));
    computeNextRow();
    return mSum;
  }


}
