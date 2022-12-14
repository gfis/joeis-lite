package irvine.oeis.a237;
// manually anopan 0,0

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a000.A000009;
import irvine.oeis.a025.A025157;

/**
 * A237976 Number of strict partitions of n such that (least part) &lt; number of parts.
 * @author Georg Fischer
 */
public class A237976 extends AbstractSequence {

  private A000009 mSeq1 = new A000009();
  private A025157 mSeq2 = new A025157();

  /** Construct the sequence. */
  public A237976() {
    super(0);
    mSeq1.next();
    mSeq2.next();
  }

  @Override
  public Z next() {
    return mSeq1.next().subtract(mSeq2.next());
  }
}
