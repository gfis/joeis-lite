package irvine.oeis.a143;

import irvine.math.z.Z;
import irvine.oeis.triangle.UpperLeftTriangle;

/**
 * A143325 Table T(n,k) by antidiagonals. T(n,k) is the number of length n primitive (=aperiodic or period n) k-ary words (n,k &gt;= 1) which are earlier in lexicographic order than any other word derived by cyclic shifts of the alphabet.
 * @author Georg Fischer
 */
public class A143325 extends A143324 {

  @Override
  public Z matrixElement(final int n, final int k) {
    return super.matrixElement(n, k).divide(k);
  }
}
