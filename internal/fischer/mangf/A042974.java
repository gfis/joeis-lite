package irvine.oeis.a042;
// manually 2021-03-04

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A042974 n 1's followed by a 2.
 * @author Georg Fischer
 */
public class A042974 implements Sequence {

  private int m1Len; // length of current block of 1's
  private int m1Count; // index in current block of 1's
  private int mState; // 1 when 1's must be output, 2 for the 2

  /** Construct the sequence */
  public A042974() {
    m1Len = 1;
    m1Count = 0;
    mState = 1;
  }

  @Override
  public Z next() {
    Z result = Z.ONE;
    ++m1Count;
    if (mState == 1) {
      if (m1Count >= m1Len) {
        mState = 2;
      }
    } else { // mstate == 2
      mState = 1;
      result = Z.TWO;
      m1Len ++;
      m1Count = 0;
    }
    return result;
  }
}
