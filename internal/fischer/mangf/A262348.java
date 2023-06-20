package irvine.oeis.a262;
// manually amoda

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a000.A000045;
import irvine.oeis.a000.A000215;

/**
 * A262348 a(n) = A000215(n) mod A000045(n).
 * @author Georg Fischer
 */
public class A262348 extends AbstractSequence {

  private A000215 mSeq1 = new A000215();
  private A000045 mSeq2 = new A000045();

  /** Construct the sequence. */
  public A262348() {
    super(1);
    mSeq1.next();
    mSeq2.next();
  }

  @Override
  public Z next() {
    return mSeq1.next().mod(mSeq2.next());
  }
}
