package irvine.oeis.a187;
// Generated by gen_seq4.pl dersimple at 2022-12-15 23:30

import irvine.math.z.Z;
import irvine.oeis.Sequence0;
import irvine.oeis.a076.A076628;

/**
 * A187131 Numerator of probability that the height of a rooted random binary tree is n.
 * @author Georg Fischer
 */
public class A187131 extends Sequence0 {

  private final A076628 mSeq = new A076628();

  @Override
  public Z next() {
    return mSeq.next().square();
  }
}
