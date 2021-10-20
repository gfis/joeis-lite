package irvine.oeis.a130;
// manually triprod at 2021-10-10 19:58

import irvine.math.z.Z;
import irvine.oeis.triangle.Triangle;

/**
 * A130296 Triangle read by rows: T[i,1]=i, T[i,j]=1 for 1 < j <= i = 1,2,3,...
 * @author Georg Fischer
 */
public class A130296 extends Triangle {

  /** Construct the sequnce */
  public A130296 () {
    super();
  }

  /**
   * Computes an element of the triangle.
   * @param n row number
   * @param k column number
   * @return T(n,k)
   */
  protected Z compute(final int n, final int k) {
    Z result = null;
    if (k < 0 || k > n) {
      result = Z.ZERO;
    } else if (n == 0) { 
      result = Z.ONE;
    } else if (k == 0) { 
      result = Z.valueOf(n + 1);
    } else {
      result = Z.ONE;
    }
    return result;
  }
}
