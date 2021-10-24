package irvine.oeis.a072;
// manually 2021-10-21

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.Sequence;

/**
 * A072921 a(1)=1; a(n) = a(n-1) + [sum of all decimal digits present so far in the sequence].
 * <code>a(1)=1, a(2)=2; a(n+1)=2*a(n)-a(n-1)+sod(a(n))</code> (sod = "sum of digits"): 1, 2, 5, 13, 25
 * @author Georg Fischer
 */
public class A072921 implements Sequence {

  private final Z mStart;
  private Z mA_1;
  private Z mA_2;

  /** Construct the sequence. */
  public A072921() {
    this(1);
  }

  /**
   * Generic constructor with parameters
   * @param start 
   */
  public A072921(final long start) {
    mStart = Z.valueOf(start);
    mA_2 = mStart.negate();
    mA_1 = Z.ZERO;
  }

  @Override
  public Z next() {
    Z result = mA_1.multiply2().subtract(mA_2).add(ZUtils.digitSum(mA_1));
    mA_2 = mA_1.isZero() ? mStart : mA_1;
    mA_1 = result;
    return result;
  }
}
