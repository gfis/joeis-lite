package irvine.oeis.a071;
// manually 2021-10-08

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.TriangleRecurrence;

/**
 * A071919 Number of monotone nondecreasing functions [n]-&gt;[m] for n&gt;=0, m&gt;=0, read by antidiagonals. 
 * @author Georg Fischer
 */
public class A071919 extends TriangleRecurrence {

  private Z[] mInits;
  private final int mLen; // mInits.size()
  protected int mN; // linear index

  /** Construct the sequence. */
  public A071919() {
    this(1, 1, 0);
  }

  /**
   * Generic constructor with parameters
   * @param inits initial terms
   */
  public A071919(final long... inits) {
    mInits = ZUtils.toZ(inits);
    mLen = mInits.length;
    mN = -1;
  }

  @Override
  /**
   * Computes an element of the triangle.
   * @param n row number
   * @param k column number
   * @return T(n,k)
   */
  protected Z compute(final int n, final int k) {
    Z result = null;
    ++mN;
    if (mN < mLen) {
      result = mInits[mN];
    } else {
      result = super.compute(n, k);
    }
    return result;
  }
}
