package irvine.oeis.a038;

import irvine.math.LongUtils;
import irvine.math.z.DirichletSeries;
import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A038540 a(n) = number of modules with n elements over the ring of integers in the real quadratic field of discriminant 40.
 * @author Sean A. Irvine
 */
public class A038540 implements Sequence {

  private final long mD;
  private int mN = 0;

  protected A038540(final long d) {
    mD = d;
  }

  /** Construct the sequence. */
  public A038540() {
    this(40);
  }

  @Override
  public Z next() {
    ++mN;
    final DirichletSeries ds1 = new DirichletSeries();
    final DirichletSeries ds2 = new DirichletSeries();
    for (int k = 1; k <= mN; ++k) {
      ds1.put(Z.valueOf(k), Z.ONE);
      final int kronecker = LongUtils.kronecker(mD, k);
      if (kronecker != 0) {
        ds2.put(Z.valueOf(k), Z.valueOf(kronecker));
      }
    }
    DirichletSeries v = ds1.multiply(ds2, mN);
    final DirichletSeries bigZ = v;
    for (int j = 2; j <= LongUtils.lg(mN); ++j) {
      final DirichletSeries u = new DirichletSeries();
      for (Z k = Z.ONE; k.compareTo(Z.valueOf(mN).root(j)) <= 0; k = k.add(1)) {
        u.put(k.pow(j), bigZ.get(k));
      }
      v = v.multiply(u, mN);
    }
    return v.coeff(mN);
  }
}
