package irvine.oeis.triangle;

import irvine.math.z.Z;
import irvine.oeis.MemorySequence;
import irvine.oeis.Sequence;

/**
 * Multiply two triangles: T = S1 * S2.
 * The target elements are generated row by row, 
 * where T(n,k) = InnerProduct(row(S1,n), column(S2,k)).
 * Here, the columns are always not longer than the rows.
 * @author Georg Fischer
 */
public class Product extends Triangle {

  protected MemorySequence mS1; // left multiplicant
  protected MemorySequence mS2; // right multiplicant

  /**
   * Constructor with two triangles.
   * @param s1 sequence for left triangle
   * @param s2 sequence for right triangle
   */
  public Product(final Sequence s1, final Sequence s2) {
    mS1 = MemorySequence.cachedSequence(s1);
    mS2 = MemorySequence.cachedSequence(s2);
  }
  
  /**
   * Gets an element of a triangle that is overlaid on a flat sequence.
   * @param s a cached (triangle) sequence
   * @param n row number
   * @param k column number
   * @return T(n,k), or 0 for k &lt; 0 or k &gt; n.
   */
  protected Z getElement(final MemorySequence s, final int n, final int k) {
    return (k < 0 || k > n) ? Z.ZERO : s.a(n * (n + 1) / 2 + k);
  }

  /**
   * Computes an element of the resulting triangle.
   * @param n row number
   * @param k column number
   * @return T(n,k)
   */
  @Override
  protected Z compute(final int n, final int k) {
    Z result = Z.ZERO;
    ++mN;
    if (k < 0 || k > n) {
      // already = 0
    } else {
      for (int icol1 = 0; icol1 <= n; ++icol1) {
          result = result.add(getElement(mS1, n, icol1).multiply(getElement(mS2, icol1, k)));
      }
    }
    return result;
  }
}
