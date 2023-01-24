package irvine.oeis.a289;

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a000.A000521;

/**
 * A289063 Coefficients in expansion of E_6^2/Product_{k&gt;=1} (1-q^k)^24.
 * @author Georg Fischer
 */
public class A289063 extends AbstractSequence {

  private final A000521 mSeq;
  private int mN = -1;

  /** Construct the sequence. */
  public A289063() {
    super(0);
    mSeq = new A000521();
  }

  @Override
  public Z next() {
    final Z result = mSeq.next();
    return (++mN == 1) ? Z.valueOf(-984) : result;
  }
}
