package irvine.oeis.a060;

import java.util.function.BiFunction;

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.Sequence;

/**
 * A060035 Least m >= 0 such that 2^m has n 2's in its base-3 expansion.	nonn,base,more,synth	0..41	nyi
 * @author Georg Fischer
 */
public class A060035 implements Sequence {

  private int mN;
  private int mStartM;
  private BiFunction<Integer, Integer, Boolean> mLambda;

  /** Construct the sequence. */
  public A060035() {
    this(0, 0, (n, m) -> ZUtils.digitCounts(Z.ONE.shiftLeft(m), 3)[2] == n);
  }

  /**
   * Generic constructor with parameters
   * @param offset first index
   * @param startM first value of <code>m</code>
   * @param lambda 
   */
  public A060035(final int offset, final int startM, final BiFunction<Integer, Integer, Boolean> lambda) {
    mN = offset - 1;
    mStartM = startM - 1;
    mLambda = lambda;
  }

  @Override
  public Z next() {
    ++mN;
    int m = mStartM;
    while (!mLambda.apply(mN, ++m)) {
    }
    return Z.valueOf(m);
  }
}