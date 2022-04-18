package irvine.oeis.a245;

import irvine.math.z.Z;
import irvine.oeis.Sequence;
import irvine.oeis.a024.A024638;

/**
 * A245399 Number of nonnegative integers with property that their base 6/5 expansion (see A024638) has n digits.
 * @author Georg Fischer
 */
public class A245399 implements Sequence {

  private int mN = 0;
  private int mLen = 1;
  private int mCount = 0;
  private Sequence mSeq;
  
  /** Construct the sequence. */
  public A245399() {
    this (new A024638());
  }
  
  /**
   * Generic constructor with parameter.
   * @param seq underlying sequence
   */
  public A245399(final Sequence seq) {
    mSeq = seq;
  }

  @Override
  public Z next() {
    ++mN;
    int len = mSeq.next().toString().length();
    while (len == mLen) {
      ++mCount;
      len = mSeq.next().toString().length();
    } 
    final Z result = Z.valueOf(mCount);
    mCount = 1;
    mLen = len;
    return result;
  }
}
