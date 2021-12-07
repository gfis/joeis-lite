package irvine.oeis.a289;

import java.util.ArrayList;

import irvine.math.group.GaussianIntegers;
import irvine.math.z.Binomial;
import irvine.math.z.Z;
import irvine.oeis.Sequence;
import irvine.util.Pair;

/**
 * A289064 Recurrence a(n+2) = Sum_{k=0..n} binomial(n,k)*a(k)*a(n+1-k) with a(0)=1, a(1)=-1.
 * @author Georg Fischer
 */
public class A289064 extends ArrayList<Pair<Z, Z>> implements Sequence {

  protected static final GaussianIntegers GI = GaussianIntegers.SINGLETON;
  protected Pair<Z, Z> mA0;
  protected Pair<Z, Z> mA1;
  protected int mRi; // 0 for result = re(), 1 for im()
  protected int mN;

  /** Construct the sequence. */
  public A289064() {
    this(1, -1, 0, 0);
  }

  /**
   * Generic constructor with parameters
   * @param a0 real part of a(0)
   * @param a1Re real part of a(1)
   * @param a1Im imaginary part of a(1)
   * @param ri whether the result is the real (0) or the imaginary (1) part
   */
  public A289064(final int a0, final int a1Re, final int a1Im, final int ri) {
    mA0 = new Pair<>(Z.valueOf(a0), Z.ZERO);
    mA1 = new Pair<>(Z.valueOf(a1Re), Z.valueOf(a1Im));
    mRi = ri;
    mN = -1;
  }

  public Pair<Z, Z> computeNext() {
    ++mN;
    if (mN == 0) {
      return mA0;
    } else if (mN == 1) {
      return mA1;
    }
    Pair<Z, Z> sum = GI.zero();
    for (int k = mN - 2; k >= 0; --k) {
      sum = GI.add(sum, GI.multiply(a(k), GI.multiply(a(mN - 1 - k), new Pair<Z, Z>(Binomial.binomial(mN - 2, k), Z.ZERO))));
    }
    return sum;
  }

  @Override
  public Z next() {
    final Pair<Z, Z> t = computeNext();
    add(t);
    return mRi == 0 ? GI.re(t) : GI.im(t);
  }

  /**
   * Return <code>a(n)</code>. If the value of <code>a(n)</code> is not already computed,
   * automatically compute all terms &lt;= n before returning with <code>a(n)</code>.
   * @param n index
   * @return value of <code>a(n)</code>
   */
  public Pair<Z, Z> a(final int n) {
    while (n >= size()) {
      add(computeNext());
    }
    return get(n);
  }

/*
public class A002607 implements Sequence {

  private static final GaussianIntegers GI = GaussianIntegers.SINGLETON;
  private int mN = 0;

  @Override
  public Z next() {
    final int m = (int) Math.sqrt(++mN);
    Pair<Z, Z> sum = GI.zero();
    for (int j = -m; j <= m; ++j) {
      final int j2 = j * j;
      for (int k = -m; k <= m; ++k) {
        final int pos = j2 + k * k;
        if (pos == mN) {
          final Pair<Z, Z> jk = new Pair<>(Z.valueOf(j), Z.valueOf(k));
          final Pair<Z, Z> c = GI.pow(jk, 8);
          sum = GI.add(sum, c);
        }
      }
    }
    assert GI.im(sum).isZero();
    return GI.re(sum).divide(4);
  }
}
*/

}
