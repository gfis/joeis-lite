package irvine.oeis.a036;
// manually like A035537 2020-09-14

import irvine.math.MemoryFunctionIntArray;
import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A036801 Number of partitions satisfying (cn(0,5) <= cn(2,5) and cn(0,5) <= cn(3,5) and cn(0,5) <= cn(1,5) and cn(0,5) <= cn(4,5)).
 * @author Georg Fischer
 */
public class A036801 extends MemoryFunctionIntArray<Z> implements Sequence {

  protected final int mMult; // multiply mN by this factor
  protected final int mImod; // take i mod this number
  protected int mN; // index of next term

  /** Construct with default parameters. */
  public A036801() {
    this(1, 1, 5);
  }

  /**
   * Construct the sequence.
   * @param offset index of first term
   * @param mult multiply n by this factor
   * @param imod take i mod this number
   */
  public A036801(final int offset, final int mult, final int imod) {
    mImod = imod;
    mMult = mult;
    mN = offset - 1;
  }

  /**
   * Recursively evaluate all partitions and accumulate information for the condition
   * @param n first int parameter
   * @param i second int parameter
   * @param c array of additional int parameters
   * @return number of partitions of n with this condition
   */
  @Override
  protected Z compute(final int n, final int i, final int[] cn) {
    final Z result;
    if (n == 0) {
      result = select(cn) ? Z.ONE : Z.ZERO;
    } else {
      if (i < 1) {
        result = Z.ZERO;
      } else {
        final int ni = n - i;
        final int imod = i % mImod;
        final int[] cnew = new int[mImod];
        for (int ic = 0; ic < mImod; ++ic) {
        	cnew[ic] = cn[ic];
        	if (imod == ic) {
        		++cnew[ic];
        	}
        } 
        result = get(n, i - 1, cn).add(get(ni, Math.min(ni, i), cnew));
      }
    }
    return result;
  }

  /**
   * Selects the proper combination of modulo conditions
   * @param cn array of the additional parameters of the recursive function {@link #compute}.
   * @return true if the combination should be selected
   */
  protected boolean select(final int[] cn) {
  	return cn[0] <= cn[2] && cn[0] <= cn[3] && cn[0] <= cn[1] && cn[0] <= cn[4];
  }
  
  /**
   * Compute the next term of the sequence
   * @return a specific number of partitions
   */
  @Override
  public Z next() {
    ++mN;
    return get(mN * mMult, mN * mMult, new int[] { 0, 0, 0, 0, 0 });
  }

}