package irvine.oeis;

import irvine.math.z.Z;

/**
 * Generate the rows of a triangle T(n,k).
 * The sequence runs through T(n,k) for k = 0 to n and n &gt;= 0.
 * The internal calling sequence is <code>++n, addRow(n), set(n,k=0..n)</code>.
 * The class maintains a ring buffer of rows with a certain depth <code>m</code>,
 * and the contract is that all calls <code>set(n, k)</code> can access the elements
 * in previous rows with <code>get(n - i, k)</code> for <code>i=1..m-1</code>,
 * and in the current row with <code>get(n, k - j)</code> for <code>j=1..k</code>.
 * @author Georg Fischer
 */
public class TriangleRecurrence implements Sequence {

  protected int mN; // current row index n
  protected int mK; // current column index k
  protected Z[][] mRows; // a circular buffer for the rows
  private int mMask; // limits the first dimension of mRows: mod 2^m - 1

  /**
   * Empty constructor.
   * Generates an ordinary Pascal triangle (A007318).
   */
  public TriangleRecurrence() {
    initialize();
  }

  /**
   * Initializes the data structure.
   * Collects the code that is common to all constructors.
   */
  private void initialize() {
    mN = -1;
    mK = 0; // start with first element T(0,0)
    setDepth(4); // allow for recurrences involving T(n-3,k)
  }
  
  /**
   * Sets the depth of the ring buffer for rows.
   * @param depth a small integer, truncated to a power of 2: 2, 4, 8.
   */
  protected void setDepth(final int depth) {
    int m = 1;
    while (m * 2 < depth) {
      m *= 2;
    }
    mMask = m - 1; // bit mask for the access to the ring buffer
    mRows = new Z[m][0];
  }
  
  /**
   * Sets a the value of a column in the current row.
   * @param k column number
   * @param value T(n,k)
   */
  protected void set(final Integer k, final Z value) {
    mRows[mN & mMask][k] = value;
  }

  /**
   * Gets an element of the triangle.
   * The default implementation here is Pascal's rule.
   * @param n row number
   * @param k column number
   * @return T(n,k)
   */
  protected Z get(final Integer n, final Integer k) {
    return (k < 0 || k > n) ? Z.ZERO : mRows[n & mMask][k];
  }

  /**
   * Increases the row index, adds a new, empty row and resets the column index.
   */
  protected void addRow() {
    ++mN;
    mRows[mN & mMask] = new Z[mN + 1];
    mK = 0;
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
      result = Z.ONE; // borders = 1
    } else {
      result = get(n - 1, k - 1).add(get(n - 1, k)); // Pascal's rule
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
      addRow();
    }
    final Z result = compute(mN, mK);
    set(mK, result);
    return result;
  }

  /**
   * Debugging output of a row
   * @param n row number
   */
  public void printRow(final int n) {
    System.out.print(String.format("%4d: ", n));
    for (int k = 0; k <= n; ++k) {
      final Z term = get(n, k);
      System.out.print(String.format("%5s", term == null ? "null" : term.toString()));
    }
    System.out.println();
  }
}