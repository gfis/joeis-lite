package irvine.oeis.a238;
// Generated by gen_seq4.pl amoda

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a000.A000041;
import irvine.oeis.a238.A238478;

/**
 * A238479 Number of partitions of n whose median is not a part.
 * @author Georg Fischer
 */
public class A238479 extends AbstractSequence {

  private A000041 mSeq1 = new A000041();
  private A238478 mSeq2 = new A238478();

  /** Construct the sequence. */
  public A238479() {
    super(1);
    mSeq1.next();
  }

  @Override
  public Z next() {
    return mSeq1.next().subtract(mSeq2.next());
  }
}