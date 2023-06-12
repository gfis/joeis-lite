package irvine.oeis.a362;
// Generated by gen_seq4.pl anopan 0,0

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a000.A000041;
import irvine.oeis.a033.A033638;

/**
 * A362548 Number of partitions of n with at least three parts larger than 1.
 * @author Georg Fischer
 */
public class A362548 extends AbstractSequence {

  private A000041 mSeq1 = new A000041();
  private A033638 mSeq2 = new A033638();

  /** Construct the sequence. */
  public A362548() {
    super(0);
  }

  @Override
  public Z next() {
    return mSeq1.next().subtract(mSeq2.next());
  }
}
