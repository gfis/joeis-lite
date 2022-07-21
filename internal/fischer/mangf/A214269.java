package irvine.oeis.a214;

import irvine.math.MemoryFunctionInt2;
import irvine.math.MemoryFunctionInt5;
import irvine.math.z.Z;
import irvine.oeis.triangle.Triangle;

/**
 * A214269 Number T(n,k) of compositions of n where the difference between largest and smallest parts equals k and adjacent parts are unequal; triangle T(n,k), n&gt;=1, 0&lt;=k&lt;n, read by rows.
 * @author Georg Fischer
 */
public class A214269 extends Triangle {

  /** Construct the sequence. */
  public A214269() {
    super(1);
    hasRAM(true);
  }

  /* Maple:
    b:= proc(n, k, s, t, l) option remember;
          `if`(n<0, 0, `if`(n=0, 1, add(`if`(j=l, 0, b(n-j, k,
           min(s, j), max(t, j), j)), j=max(1, t-k+1)..s+k-1)))
        end:
    A:= proc(n, k) option remember;
          `if`(n=0, 1, add(b(n-j, k+1, j, j, j), j=1..n))
        end:
    T:= (n, k)-> A(n, k) -`if`(k=0, 0, A(n, k-1)):
    seq(seq(T(n, k), k=0..n-1), n=1..14);
  */
  private final static MemoryFunctionInt5<Z> mB = new MemoryFunctionInt5<Z>() {
    @Override
    protected Z compute(final int n, final int k, final int s, final int t, final int l) {
      if (n < 0) {
        return Z.ZERO;
      }
      if (n == 0) {
        return Z.ONE;
      }
      Z sum = Z.ZERO;
      final int jmax = s + k - 1;
      for (int j = (1 > t - k + 1 ? 1 : t - k + 1); j <= jmax; ++j) {
        if (j != l) {
          sum = sum.add(get(n - j, k, (s < j ? s : j), (t > j ? t : j), j));
        }
      }
      return sum;
    }
  };

  public final static MemoryFunctionInt2<Z> mA = new MemoryFunctionInt2<Z>() { // used in A214268
    @Override
    protected Z compute(final int n, final int k) {
      if (n == 0) {
        return Z.ONE;
      }
      Z sum = Z.ZERO;
      for (int j = 1; j <= n; ++j) {
        sum = sum.add(mB.get(n - j, k + 1, j, j, j));
      }
      return sum;
    }
  };

  @Override
  protected Z compute(int n, final int k) {
    ++n;
    Z result = mA.get(n, k);
    if (k != 0) {
      result = result.subtract(mA.get(n, k - 1));
    }
    return result;
  }
}
