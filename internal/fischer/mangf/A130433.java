package irvine.oeis.a130;

import irvine.math.z.Z;
import irvine.oeis.SequenceWithOffset;

/**
 * A130433 Even pseudoprimes to base 3.
 * @author Georg Fischer
 */
public class A130433 implements SequenceWithOffset {

  private int mN;
  private int mOffset;
  private Z mBase;

  /** Construct the sequence. */
  public A130433() {
    this(1, 3);
  }

  /**
   * Generic constructor with parameters
   * @param offset 
   * @param base 
   */
  public A130433(final int offset, final int base) {
    mN = 2;
    mOffset = offset;
    mBase = Z.valueOf(base);
  }

  // MMA: lst = {}; Do[ If[ PowerMod[3, 2n - 1, 2n] == 1, AppendTo[lst, 2n]; Print[2n]], {n, 2, 24000000}]; lst
  // (PARI) forstep(n=4, 10^10, 2, Mod(3, n)^(n-1)==1 && print1(n, ", "))
  @Override
  public Z next() {
    while (true) {
      mN += 2;
      final Z nz = Z.valueOf(mN);
      if (mBase.modPow(Z.valueOf(mN - 1), nz).equals(Z.ONE)) {
        return nz;
      }
    }
  }

  @Override
  public int getOffset() {
    return mOffset;
  }
}
