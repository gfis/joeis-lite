package irvine.oeis.triangle;

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * Multiply two triangles: T = S1 * S2.
 * The target elements are generated row by row,
 * where T(n,k) = InnerProduct(row(S1,n), column(S2,k)).
 * Here, the columns are always not longer than the rows.
 * @author Georg Fischer
 */
public class Product extends Triangle {

  protected Triangle mS1; // left source multiplicant
  protected Triangle mS2; // right source multiplicant

  /**
   * Constructor with two triangles.
   * @param s1 sequence for left triangle
   * @param s2 sequence for right triangle
   */
  public Product(final Triangle s1, final Triangle s2) {
    mS1 = s1;
    mS2 = s2;
  }

  /**
   * Constructor with two Sequences.
   * @param s1 sequence for left triangle
   * @param s2 sequence for right triangle
   */
  public Product(final Sequence s1, final Sequence s2) {
    this(Triangle.asTriangle(s1), Triangle.asTriangle(s2));
  }

  /**
   * Increases <code>mRow</code>, adds a new, empty target row, resets the column index,
   * and advances both source sequences such that their <code>mRow</code> is completely filled.
   */
  protected void addRow() {
    super.addRow();
    for (int i = 0; i <= mRow; ++i) {
      mS1.next();
      mS2.next();
    }
  }

  /**
   * Computes an element of the resulting triangle.
   * <code>addRow()</code> has made sure that rows <code>n</code> of both source triangles are completely filled.
   * @param n row number
   * @param k column number
   * @return <code>T(n,k) = sum(S1(n,j) * S2(j,k), j=0..n)</code>
   */
  @Override
  protected Z compute(final int n, final int k) {
    ++mN;
    Z result = Z.ZERO;
    for (int j = 0; j <= n; ++j) {
      final Z s1nj = mS1.get(n, j);
      if (s1nj == null) {
        System.err.println("assertion failed: s1nj=null in Product.compute(" + n + ", " + j + ")");
      }
      final Z s2jk = mS2.get(j, k);
      if (s2jk == null) {
        System.err.println("assertion failed: s2jk=null in Product.compute(" + j + ", " + k + ")");
      }
      result = result.add(s1nj.multiply(s2jk));
    }
    return result;
  }
}
