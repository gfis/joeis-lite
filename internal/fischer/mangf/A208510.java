package irvine.oeis.a208;
// manually 2021-09-03

import irvine.math.group.IntegerField;
import irvine.math.group.PolynomialRingField;
import irvine.math.polynomial.Polynomial;
import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A208510 Triangle of coefficients of polynomials u(n,x) jointly generated with A029653; see the Formula section.
 * @author Georg Fischer
 */
public class A208510 implements Sequence {

  private static final PolynomialRingField<Z> RING = new PolynomialRingField<>(IntegerField.SINGLETON);
  protected Polynomial<Z> mA2; // coefficient of uv(2,x)
  protected Polynomial<Z> mC0; // constant
  protected Polynomial<Z> mN1; // coefficient of uv(n-1, x)
  protected Polynomial<Z> mN2; // coefficient of uv(n-2, x)
  protected Polynomial<Z> mUV; // current recurrence element
  protected Polynomial<Z> mUV_1; // previous recurrence element
  protected Polynomial<Z> mUV_2; // element before the previous recurrence element
  protected boolean mDn; // whether n must be added to parameter d
  protected int mRow; // number of row >= 1, n in uv(n,x)
  protected int mCol; // number of column, 1 <= mCol <= mRow
  protected int mN; // current index

  /** Construct the sequence. */
  public A208510() {
    this(Polynomial.create(1,1), Polynomial.create(0,1), Polynomial.create(1,1), Polynomial.create(0), false);
  }

  /**
   * Generic constructor with parameters
   * @param a2 polynomial uv(2,x)
   * @param c0 constant
   * @param n1 factor before uv(n-1, x)
   * @param n2 factor before uv(n-2, x)
   */
  public A208510(final Polynomial<Z> a2, final Polynomial<Z> c0, final Polynomial<Z> n1, final Polynomial<Z> n2, final boolean dn) {
    mN = 0;
    mA2 = a2;
    mC0 = c0;
    mN1 = n1;
    mN2 = n2;
    mDn = dn;
    mRow = 0;
    mCol = 0;
  }

  private void buildNextRow() {
    ++mRow;
    mCol = 0;
    if (mRow == 1) {
      mUV = Polynomial.create(1); // uv(1,x) = 1
    } else if (mRow == 2) {
      mUV_1 = mUV;
      mUV = mA2;
    } else {
      mUV_2 = mUV_1;
      mUV_1 = mUV;
      mUV = RING.add(RING.multiply(mN2, mUV_2), RING.add(RING.multiply(mN1, mUV_1), mC0));
    }
  }


  @Override
  public Z next() {
    ++mN;
    ++mCol;
    if (mCol >= mRow) {
      buildNextRow();
    }
    return mUV.coeff(mCol);
  }
}
