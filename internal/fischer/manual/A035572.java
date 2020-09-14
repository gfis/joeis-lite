package irvine.oeis.a035;
// manually like A035537 2020-09-12

import irvine.math.MemoryFunctionInt5;
import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A035572 Number of partitions of n with equal number of parts congruent to each of 0, 1 and 2 (mod 5)
 * @author Georg Fischer
 */
public class A035572 extends MemoryFunctionInt5<Z> implements Sequence {

  protected final int[] mModules; // which combination of elements to select
  protected final int mImod; // take i mod this number
  protected int mN; // index of next term

  /** Construct with default parameters. */
  public A035572() {
    this(0, 5, 0, 1, 2);
  }

  /**
   * Construct the sequence.
   * @param offset index of first term
   * @param imod take i mod this number
   * @param modules vector of valid values
   */
  public A035572(final int offset, final int imod, final int... modules) {
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
   * @param r third accumulator
   * @return number of partitions of n with this condition
   */
  @Override
  protected Z compute(final int n, final int i, final int t, final int s, final int r) {
    final Z result;
    if (n == 0) {
      result = (t >= 0
          && t == s
          && s == r
          ) ? Z.ONE : Z.ZERO;
    } else {
      if (i < 1) {
        result = Z.ZERO;
      } else {
        final int ni = n - i;
        final int imod = i % mImod;
        result = get(n, i - 1, t, s, r)
            .add(get(ni, Math.min(ni, i)
            , t + (mModules[0] == imod ? 1 : 0)
            , s + (mModules[1] == imod ? 1 : 0)
            , r + (mModules[2] == imod ? 1 : 0)
            ));
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
    return get(mN, mN, 0, 0, 0);
  }

}