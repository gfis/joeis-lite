package irvine.oeis.a225;

import irvine.math.MemoryFunctionInt3;
import irvine.math.z.Z;
import irvine.oeis.triangle.Triangle;

/**
 * A225472 Triangle read by rows, k!*S_3(n, k) where S_m(n, k) are the Stirling-Frobenius subset numbers of order m; n &gt;= 0, k &gt;= 0.
 * @author Georg Fischer
 */
public class A225472 extends Triangle {

  private int mOrder;

  /** Construct the sequence. */
  public A225472 () {
    this(3);
  }

  /**
   * Generic constructor with parameter.
   * @param order order of Stirling-Frobenius subset numbers
   */
  public A225472(final int order) {
    mOrder = order;
    hasRAM(true);
  }

  /* Maple:
    SF_SO := proc(n, k, m) option remember;
    if n = 0 and k = 0 then return(1) fi;
    if k > n or k < 0 then return(0) fi;
    m*k*SF_SO(n-1, k-1, m) + (m*(k+1)-1)*SF_SO(n-1, k, m) end:
    seq(print(seq(SF_SO(n, k, 3), k=0..n)), n = 0..5);
  */
  private final MemoryFunctionInt3<Z> mB = new MemoryFunctionInt3<Z>() {
    @Override
    protected Z compute(final int n, final int k, final int m) {
      if (n == 0 && k == 0) {
        return Z.ONE;
      }
      if (k > n || k < 0) {
        return Z.ZERO;
      }
      return get(n - 1, k - 1, m).multiply(m * k).add(get(n - 1, k, m).multiply(m * (k + 1) - 1));
    }
  };
 
  @Override
  protected Z compute(final int n, final int k) {
    return mB.get(n, k, mOrder);
  }
}
