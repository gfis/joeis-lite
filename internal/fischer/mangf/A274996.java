package irvine.oeis.a274;
// manually amoda

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a007.A007570;
import irvine.oeis.a058.A058051;

/**
 * A274996 a(n) = F(F(F(n))) mod F(F(n)), where F = Fibonacci = A000045.
 * @author Georg Fischer
 */
public class A274996 extends AbstractSequence {

  private A058051 mSeq1 = new A058051();
  private A007570 mSeq2 = new A007570();

  /** Construct the sequence. */
  public A274996() {
    super(1);
    mSeq1.next();
    mSeq2.next();
  }

  @Override
  public Z next() {
    return mSeq1.next().mod(mSeq2.next());
  }
}
