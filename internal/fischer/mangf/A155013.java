package irvine.oeis.a155;

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;

/**
 * A155013 Integer part of square root of A000584.
 * @author Georg Fischer
 */
public class A155013 extends AbstractSequence {

  private long mN;
  private int mExpon;

  /** Construct the sequence. */
  public A155013() {
    this(1, 5);
  }

  /**
   * Generic constructor with parameters
   * @param expon exponent of n
   */
  public A155013(final int offset, final int expon) {
    super(offset);
    mN = offset - 1;
    mExpon = expon;
  }

  @Override
  public Z next() {
    return Z.valueOf(++mN).pow(mExpon).sqrt();
  }
}
