package irvine.oeis.triangle;

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * Compute the inverse of a triangle: S * Inverse(S) = Identity.
 * The target elements are generated row by row, 
 * where T(n,k) = InnerProduct(row(S1,n), column(S2,k)).
 * Here, the columns are always not longer than the rows.
 * @author Georg Fischer
 */
public class Inverse extends Triangle {

  protected Triangle mS; // source triangle
  
  /**
   * Constructor with one triangle.
   * @param s1 sequence for source triangle
   */
  public Inverse(final Triangle s) {
    mS = s;
  }
  
  /**
   * Computes an element of the resulting triangle.
   * @param n row number
   * @param k column number
   * @return T(n,k)
   */
  @Override
  protected Z compute(final int n, final int k) {
    Z sum = Z.ZERO;
    if (k < 0 || k > n) {
      // already = 0
    } else {
      for (int j = 0; j <= n; ++j) {
        sum = sum.add(this.get(n, j).multiply(mS.get(j, k)));
      }
    }
    return sum;
  }
}
