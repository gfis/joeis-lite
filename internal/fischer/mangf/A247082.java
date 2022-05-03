package irvine.oeis.a247;
// Generated by gen_seq4.pl egfsi/egfsie at 2021-12-02 19:59

import irvine.math.group.PolynomialRingField;
import irvine.math.q.Q;
import irvine.math.q.Rationals;
import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A247082 E.g.f.: (8 - 7*cosh(x)) / (13 - 12*cosh(x)).
 * E.g.f.: (8 - 7*cosh(x)) / (13 - 12*cosh(x)), even powers
 * @author Georg Fischer
 */
public class A247082 implements Sequence {

  private static final PolynomialRingField<Q> RING = new PolynomialRingField<>(Rationals.SINGLETON);
  private int mN = -1;
  private Z mF = Z.ONE;

  @Override
  public Z next() {
    while ((++mN & 1) == 1) {
      if (mN != 0) {
        mF = mF.multiply(mN);
      }
    }
    if (mN != 0) {
      mF = mF.multiply(mN);
    }
    return RING.series(RING.subtract(RING.monomial(new Q(8),0),RING.multiply(RING.monomial(new Q(7),0),RING.cosh(RING.x(),mN),mN)),RING.subtract(RING.monomial(new Q(13),0),RING.multiply(RING.monomial(new Q(12),0),RING.cosh(RING.x(),mN),mN)),mN).coeff(mN).multiply(mF).toZ();
  }
}