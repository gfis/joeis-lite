package irvine.oeis.a057;

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A057934 Number of prime factors of 10^n + 1 (counted with multiplicity).
 * @author Georg Fischer
 */
public class A057934 implements Sequence {

  private int mN;
  private int mBase;
  private Z mPow;
  private int mAdd;

  /** Construct the sequence. */
  public A057934() {
    this(10, 1);
  }

  /**
   * Generic constructor with parameters
   * @param base 
   * @param add 
   */
  public A057934(final int base, final int add) {
    mN = 0;
    mBase = base;
    mPow = Z.ONE;
    mAdd = add;
  }

  @Override
  public Z next() {
    ++mN;
    mPow = mPow.multiply(mBase);
    return Z.valueOf(Jaguar.factor(mPow.add(mAdd)).bigOmega());
  }
}
