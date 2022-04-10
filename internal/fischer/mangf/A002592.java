package irvine.oeis.a002;

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A002592 Largest prime factor of 9^n + 1.
 * @author Sean A. Irvine
 */
  private Z mN = null;
  private int mBase;
  private int mAdd;

  /** Construct the sequence. */
  public A002592() {
    this(9, 1);
  }

  /**
   * Generic constructor with parameters
   * @param base base to be raised to power <code>mN</code>
   * @param add add this to the expression
   */
  public A002592(final int base, final int add) {
    mBase = Z.valueOf(base);
    mAdd = add;
  }

  @Override
  public Z next() {
    mN = mN == null ? Z.ONE : mN.multiply(mBase);
    return A002582.lpf(mN.add(mAdd));
  }
}