package irvine.oeis.a003;

import irvine.math.group.IntegerField;
import irvine.math.group.PolynomialRingField;
import irvine.math.polynomial.Polynomial;
import irvine.math.z.Z;
import irvine.oeis.Sequence;
import irvine.oeis.Sequence0;
import irvine.oeis.SkipSequence;
import irvine.oeis.transform.EulerTransform;

/**
 * A003080 Number of rooted triangular cacti with 2n+1 nodes (n triangles).
 * @author Sean A. Irvine
 */
public class A003080 extends Sequence0 {

  static final PolynomialRingField<Z> RING = new PolynomialRingField<>(IntegerField.SINGLETON);
  protected int mN = -1;
  protected Polynomial<Z> mB = null;

  private static final class PolynomialSequence extends Sequence0 {

    private final Polynomial<Z> mP;
    private int mN = -1;

    private PolynomialSequence(final Polynomial<Z> poly) {
      mP = poly;
    }

    @Override
    public Z next() {
      return ++mN > mP.degree() ? Z.ZERO : mP.coeff(mN);
    }
  }

  @Override
  public Z next() {
    mN += 2;
    if (mB == null) {
      mB = RING.x();
    } else {
      final Polynomial<Z> e = RING.divide(RING.add(mB.substitutePower(2, mN), RING.pow(mB, 2, mN)), Z.TWO);
      final Sequence euler = new EulerTransform(new SkipSequence(new PolynomialSequence(e), 1), 1);
      for (int k = 1; k < mN; ++k) {
        euler.next();
      }
      mB = RING.add(mB, RING.monomial(euler.next(), mN));
    }
    return mB.coeff(mN);
  }
}

