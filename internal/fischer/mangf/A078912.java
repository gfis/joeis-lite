package irvine.oeis.a078;

import java.util.function.BiFunction;
import java.util.function.Function;

import irvine.math.z.Z;
import irvine.oeis.MemorySequence;

/**
 * A078912 a(1)=a(2)=1, a(n)=a(n-1)+a(n-2) if n is odd, a(n)=a(n-1)+a(n/2) if n is even.
 * @author Georg Fischer
 */
public class A078912 implements MemorySequence {

  private int mN;
  private int mModul;
  private BiFunction<Integer, Z> mFuncT;
  private BiFunction<Integer, Z> mFuncF;
  private int[] mInits;
  private int mILen; // length of mInits


  /** Construct the sequence. */
  public A078912() {
    this(0, 0, 0, 0);
  }

  /**
   * Generic constructor with parameters
   * @param offset index of first term
   * @param modul 2 or 3 
   * @param inits list of initial terms
   */
  public A078912(final int offset, final int modul, final int... inits, final Function<Integer, Z> funcT) {
    mN = -1;
    mModul = modul;
    mInits = inits;
    if (offset > 0) {
      add(null);
    }
    mILen = mInits.length;
    initialize();
  }

  @Override
  public Z computeNext() {
    final int n = size();
    if (n < mILen) {
      return Z.valueOf(mInits[n]);
    }
    return (n % mModul == 0) ? mFuncT.apply(n) : mFuncF.apply(n);
  }
}
