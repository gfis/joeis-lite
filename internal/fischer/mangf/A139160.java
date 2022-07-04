package irvine.oeis.a139;

import irvine.math.factorial.MemoryFactorial;
import irvine.math.z.Z;
import irvine.oeis.a000.A000040;

/**
 * A139160 a(n)=(prime(n)!+2)/2.
 * @author Georg Fischer
 */
public class A139160 extends A000040 {

  private int mN;
  private int mParm;
  private Z mAbsParm;

  /** Construct the sequence. */
  public A139160() {
    this(1, 2);
  }

  /**
   * Generic constructor with parameters
   * @param offset index of first term
   * @param parm the constant
   */
  public A139160(int offset, final int parm) {
    mN = offset - 1;
    while (offset > 1) {
      super.next();
    }
    mParm = parm;
    mAbsParm = Z.valueOf(parm < 0 ? -parm : parm);
  }

  @Override
  public Z next() {
    ++mN;
    return MemoryFactorial.SINGLETON.factorial(super.next()).add(mParm).divide(mAbsParm);
  }
}
