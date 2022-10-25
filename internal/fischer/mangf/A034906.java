package irvine.oeis.a034;

import java.util.TreeSet;

import irvine.math.z.Z;
import irvine.oeis.Sequence;
import irvine.oeis.SequenceWithOffset;
import irvine.oeis.a004.A004094;

/**
 * A034906 Powers of 2 written backwards and sorted.
 * @author Sean A. Irvine
 * @author Georg Fischer
 */
public class A034906 implements SequenceWithOffset {

  private int mN;
  private int mOffset;
  private Sequence mSeq;

  private final TreeSet<Z> mA = new TreeSet<>();
  private int mLastLength = 0;


  /** Construct the sequence. */
  public A034906() {
    this(1, new A004094());
  }

  /**
   * Generic constructor with parameters
   * @param offset first index
   * @param seq underlying sequence
   */
  public A034906(final int offset, final Sequence seq) {
    mN = 0;
    mOffset = offset;
    mSeq = seq;
  }

  @Override
  public int getOffset() {
    return mOffset;
  }

  @Override
  public Z next() {
    while (mA.isEmpty() || mA.first().toString().length() == mLastLength) {
      final Z a = mSeq.next();
      mA.add(a);
      mLastLength = a.toString().length();
    }
    return mA.pollFirst();
  }
}
