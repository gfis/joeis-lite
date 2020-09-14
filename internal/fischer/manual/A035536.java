package irvine.oeis.a035;
// manually like A035537 2020-09-12

import irvine.math.MemoryFunctionInt4;
import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A035536 Number of partitions of n with equal number of parts congruent to each of 1 and 2 (mod 3).
 * @author Georg Fischer
 */
public class A035536 extends MemoryFunctionInt4<Z> implements Sequence {

  protected final int[] mModules; // which combination of elements to select
  protected final int mImod; // take i mod this number
  protected int mN; // index of next term
  
  /** Construct with default parameters. */
  public A035536() {
    this(0, 3, 1,2);
  }
    
  /** 
   * Construct the sequence. 
   * @param offset index of first term
   * @param imod take i mod this number
   * @param modules vector of valid values
   */
  public A035536(final int offset, final int imod, final int... modules) {
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
    final Z result;
    if (n == 0) {
      result = (t == s && t >= 0) ? Z.ONE : Z.ZERO;
    } else {
      if (i < 1) {
        result = Z.ZERO;
      } else {
        final int ni = n - i;
        final int imod = i % mImod;
        result = get(n, i - 1, t, s)
          .add(get(ni, Math.min(ni, i), t + (mModules[0] == imod ? 1 : 0), s + (mModules[1] == imod ? 1 : 0)));
      }
    }
    return result;
  }
/* Maple: 
     b := proc(n, i, t, s) option remember; `if`(n=0,
      `if`(t = s and t >= 0, 1, 0), `if`(i<1, 0, b(n, i-1, t, s)+
       b(n-i, min(n-i, i), t + [1, 0, 0][1+irem(i, 3)], s + [0, 1, 0][1+irem(i, 3)])))
    end:
    seq(b(n,n, 0,0), n=0..32);
    </pre>
*/
  
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