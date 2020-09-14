package irvine.oeis.a035;
// manually 2020-09-12

import irvine.math.MemoryFunctionInt4;
import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A035679 Number of partitions of n into parts 8k+1 and 8k+2 with at least one part of each type.
 * @author Georg Fischer
 */
public class A035679 extends MemoryFunctionInt4<Z> implements Sequence {

  protected final int[] mModules; // which combination of elements to select
  protected final int mImod; // take i mod this number
  protected int mN; // index of next term
  
  /** Construct with default parameters. */
  public A035679() {
    this(1, 8, 1, 2);
  }
    
  /** 
   * Construct the sequence. 
   * @param offset index of first term
   * @param imod take i mod this number
   * @param modules vector of valid values
   */
  public A035679(final int offset, final int imod, final int... modules) {
    mImod = imod;
    mModules = modules;
    mN = offset - 1;
  }
    
  /**
   * Recursively evaluate all partitions and accumulate information for the condition
   * @param n number to be partitioned
   * @param i nesting level
   * @param t first accumulator
   * @param s second accumulator
   * @return number of partitions of n with this condition 
   */
  @Override
  protected Z compute(final int n, final int i, final int t, final int s) {
    Z result;
    if (n == 0) {
      result = Z.valueOf(t * s);
    } else {
      if (i < 1) {
        result = Z.ZERO;
      } else {
        result = get(n, i - 1, t, s);
        final int h = i % mImod;
        if (h == mModules[0] || h == mModules[1]) {
          Z sum = Z.ZERO;
          final int limit = n / i;
          for (int j = 1; j <= limit; ++j) {
            sum = sum.add(get(n - i * j, i - 1
              , h == mModules[0] ? 1 : t
              , h == mModules[1] ? 1 : s));
          }
          result = result.add(sum);
        }
      }
    }
    return result;
  }

  /**
   * Compute the next term of the sequence
   * @return a specific number of partitions
   */
  @Override
  public Z next() {
    ++mN;
    return get(mN, mN, 0, 0);
  }

}
