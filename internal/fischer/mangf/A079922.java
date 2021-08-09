package irvine.oeis.a079;

import irvine.math.api.Matrix;
import irvine.math.group.MatrixRing;
import irvine.math.matrix.DefaultMatrix;
import irvine.math.z.Integers;
import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A079922 Solution to the Dancing School Problem with n girls and n+3 boys: f(n,3).
 * @author Georg Fischer
 */
public class A079922 implements Sequence {

  protected int mN; // current index
  protected int mP; // parameter
  
  /** Construct the sequence */
  public A079922() {
    this(3);
  }
  
  /**
   * Generic constructor with parameter
   * @param h 2nd parameter of function f
   */
  public A079922(int p) {
    mP = p;
    mN = -1;
  }
  
  /**
   * Compute the function f 
   * @param g first parameter
   * @param h second parameter
   */
  /*  
        cf. http://www.jaapspies.nl/oeis/ds.sage
        m = g
        n = m + h
        M = MatrixSpace(QQ, m, n)
        for i in range(m):
            for j in range(n):
                if i <= j and j <= i + h:
                    A[i,j] = 1
        return A.permanent()
  */
  protected Z compute(final int g, final int h) {
    final int m = g;
    final int n = m + h;
    final MatrixRing<Z> danceRing = new MatrixRing<>(m * n, Integers.SINGLETON);
    final Matrix<Z> dance = new DefaultMatrix<>(m, n, Z.ZERO);
    for (int i = 0; i < m; ++i) {
      for (int j = 0; j < n; ++j) {
        if (i <= j && j <= i + h) {
            dance.set(i, j, Z.ONE);
        }
      }
    }
    return danceRing.permanent(dance);
  }
  
  @Override
  public Z next() {
    return compute(++mN, mP);
  }

}
