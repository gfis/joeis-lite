package irvine.oeis.a224;

import irvine.math.MemoryFunctionInt3;
import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A224956 Number of partitions of n where the difference between consecutive parts is at most 2.
 * @author Georg Fischer
 */
public class A224956 extends MemoryFunctionInt3<Z> implements Sequence {

  private int mN;
  private int mDiff;

  /** Construct the sequence. */
  public A224956() {
    this(2);
  }

  /**
   * Generic constructor with parameter
   * @param diff difference 
   */
  public A224956(final int diff) {
    mN = -1;
    mDiff = diff;
  }

  /** 
   * Recursive functions b, g for one element.
   * @param bg 0 for b, 1 for g
   * @param n current row index
   * @param i current column index
   * @return function value
   /
  /* Maple:
     b:= proc(n, i) option remember; `if`(n=0, 1, `if`(i<1, 0,
       add(b(n-i*j, i-1), j=0..min(3, n/i))))
     end:
     g:= proc(n, i) option remember; `if`(n=0, 1, `if`(i<1, 0,
       add(b(n-i*j, i-1), j=1..n/i)))
     end:
     a:= n-> add(g(n, k), k=0..n):
     seq(a(n), n=0..60);  # Alois P. Heinz, Mar 09 2014
   */
  @Override
  protected Z compute(final int bg, final int n, final int i) {
    if (n == 0) {
      return Z.ONE;
    }
    if (i < 1) {
      return Z.ZERO;
    }
    final int ni = n / i;
    int jmin = 0;
    int jmax = mDiff < ni ? mDiff : ni;
    if (bg == 1) {
      jmin = 1;
      jmax = ni;
    }
    Z sum = Z.ZERO;
    for (int j = jmin; j <= jmax; ++j) {
      sum = sum.add(get(0, n - i * j, i - 1));
    }
    return sum;
  }

  @Override
  public Z next() {
    ++mN;
    Z sum = Z.ZERO;
    for (int k = 0; k <= mN; ++k) {
      sum = sum.add(get(1, mN, k));
    }
    return sum;
  }
}
