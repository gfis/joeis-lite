package irvine.oeis.a035;
// manually from contrib/a035679.pl 2020-09-06

import irvine.math.z.Z;
import irvine.oeis.Sequence;
import java.util.HashMap;

/**
 * A035536 Number of partitions of n with equal number of parts congruent to each of 1 and 2 (mod 3)
 * @author Georg Fischer
 */
public class A035679 implements Sequence {

  private final HashMap<String, Z> mRemember; // simulate "option remember"
  protected final int[] mModules; // which combination of elements to select
  protected final int mImod; // take i mod this number
  protected int mN; // index of next term
  
  /** Construct with default parameters. */
  public A035679() {
    this(1, 8, 1,2);
  }
    
  /** 
   * Construct the sequence. 
   * @param offset index of first term
   * @param imod take i mod this number
   * @param modules vector of valid values
   */
  public A035679(final int offset, int imod, int ... modules) {
    mImod = imod;
    mModules = modules;
    mRemember = new HashMap<String, Z>(1000000); // termNO = 1000 consumes some 6 mio hash map entries
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
  protected Z partition (final int n, final int i, final int t, final int s) {
    final String key = String.valueOf(n) + "," + String.valueOf(i) + "," + String.valueOf(t) + "," + String.valueOf(s); // String.format is much slower?
    Z result = mRemember.get(key);
    if (result == null) {
        if (n == 0) {
            result = Z.valueOf(t).multiply(Z.valueOf(s));
        } else {
            if (i < 1) {
                result = Z.ZERO;
            } else {
                result = partition(n, i - 1, t, s);
                final int h = i % mImod;
                if (h == mModules[0] || h == mModules[1]) {
                    Z sum = Z.ZERO;
                    final int limit = n / i;
                    for (int j = 1; j <= limit; ++j) {
                        sum = sum.add(partition(n - i * j, i - 1
                            , (h == mModules[0] ? 1 : t)
                            , (h == mModules[1] ? 1 : s)));
                    } 
                    result = result.add(sum);
                }
            }
        }
        mRemember.put(key, result);
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
    return partition(mN, mN, 0, 0);
  }
}
