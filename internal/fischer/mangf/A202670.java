package irvine.oeis.a202;
// manually 2021-10-26

import irvine.math.z.Z;
import irvine.oeis.MemorySequence;
import irvine.oeis.Sequence;
import irvine.oeis.a000.A000290;
import irvine.oeis.triangle.Triangle;

/**
 * A202670 Symmetric matrix based on A000290 (the squares), by antidiagonals.
 * This is the prototype for an array called "self-fusion matrix" by Kimberling.
 * @author Georg Fischer
 */
public class A202670 extends Triangle {

  protected final MemorySequence mSeq;
  protected final int mSkip;

  /** Construct the sequence. */
  public A202670() {
    this(new A000290(), 1);
  }

  /**
   * Generic constructor with parameters
   * @param seq underlying Sequence
   * @param skip number of terms in <code>mSeq</code> to be skipped.
   * 
   */
  public A202670(final Sequence seq, int skip) {
    super();
    mSeq = MemorySequence.cachedSequence(seq);
    mSkip = skip;
  }

  /**
   * Access the underlying Sequence with shifted offset.
   * The underlying sequence is addressed as if it had offset 1, 
   * while the resulting triangle starts with <code>T(0,0)</code>.
   * @param n index
   * @return <code>mSeq(n - 1)</code> if <code>n &gt;= 1</code>, 0 otherwise.
   */
  protected Z a(final int n) {
    return n + mSkip < 0 ? Z.ZERO : mSeq.a(n + mSkip);
  }
  
  @Override
  /**
   * Computes a triangle element.
   * @param n row number, 0-based
   * @param k column number, 0-based
   * The elements are inner product sums of terms in the underlying sequence 1,4,9,16 as follows:
   * <pre>
   * n/k  0         1         2         3
   *  0   1.1       
   *  1   14.01     01.14  
   *  2   149.001   014.014   001.149
   *  3   149G.0001 0149.0014 0014.0149 0001.149G
   * </pre>
   * @return Triangle element <code>T(n, k)</code>
   */
  public Z compute(final int n, final int k) {
    if (n == 0) {
      return a(0);
    }
    Z sum = Z.ZERO;
    for (int m = 0; m <= n; ++m) { // sum over as many products as the row number
      final int il = - k + m;
      final int ir = + k - n + m;
      if (il >= 0 && ir >= 0) {
        sum = sum.add(a(il).multiply(a(ir)));
      }
      // System.out.println("\tn=" + n + "\tk=" + k + "\tm=" + m + "\ta(il=" + il + ")=" + a(il) + "\ta(ir=" + ir + ")=" + a(ir) + "\tsum=" + sum);
    }
    return sum;
  }
}
