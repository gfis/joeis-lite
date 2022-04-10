package irvine.oeis.a104;

import irvine.math.z.Z;
import irvine.oeis.a000.A000796;

/**
 * A104807 Length of sections with distinct digits in the decimal expansion of Pi.
 * @author Georg Fischer
 */
public class A104807 extends A000796 {

  private int mCount;
  private final static int[] mMasks = new int[] 
    //    9876543210 -> digits that have occurred
      { 0b0000000001
      , 0b0000000010
      , 0b0000000100
      , 0b0000001000
      , 0b0000010000
      , 0b0000100000
      , 0b0001000000
      , 0b0010000000
      , 0b0100000000
      , 0b1000000000
      };
  private long mSeen;

  /** Construct the sequence. */
  public A104807() {
    super.next();
    mSeen = mMasks[3]; // Pi = 3.14159...
    mCount = 1;
  }

  @Override
  public Z next() {
    int digit = super.next().intValue();
    while ((mSeen & mMasks[digit]) == 0) {
      mSeen |= mMasks[digit];
      ++mCount;
      digit = super.next().intValue();
    }
    final Z result = Z.valueOf(mCount);
    mCount = 1;
    mSeen = mMasks[digit];
    return result;
  }
}
