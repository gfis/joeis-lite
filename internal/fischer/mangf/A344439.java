package irvine.oeis.a344;
// manually amoda

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a344.A344440;
import irvine.oeis.a344.A344441;

/**
 * A344439 a(n) = n - A206369(n).
 * @author Georg Fischer
 */
public class A344439 extends AbstractSequence {

  private A344440 mSeq1 = new A344440();
  private A344441 mSeq2 = new A344441();

  /** Construct the sequence. */
  public A344439() {
    super(1);
  }

  @Override
  public Z next() {
    return mSeq1.next().subtract(mSeq2.next());
  }
}
