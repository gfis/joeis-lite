package irvine.oeis.a341;
// Generated by gen_seq4.pl simple3 at 2023-03-24 09:26

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a006.A006702;

/**
 * A341862 a(n) is the even term in the linear recurrence signature for numerators and denominators of continued fraction convergents to sqrt(n), or 0 if n is a square.
 * @author Georg Fischer
 */
public class A341862 extends AbstractSequence {

  private int mN = -1;
  private final A006702 mSeq = new A006702();

  /** Construct the sequence. */
  public A341862() {
    super(0);
  }

  @Override
  public Z next() {
    ++mN;
    if (mN == 0) {
      return Z.ZERO;
    }
    final Z result = Z.TWO.multiply(mSeq.next());
    return Z.valueOf(mN).isSquare() ? Z.ZERO : result;
  }
}
