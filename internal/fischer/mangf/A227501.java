package irvine.oeis.a227;
// Generated by gen_seq4.pl simple3 at 2023-03-24 09:26

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a227.A227128;

/**
 * A227501 Number of non-congruent solutions of x^2 - xy + y^2 == 1 (mod n).
 * @author Georg Fischer
 */
public class A227501 extends AbstractSequence {

  private int mN = 0;
  private final A227128 mSeq = new A227128();

  /** Construct the sequence. */
  public A227501() {
    super(1);
  }

  @Override
  public Z next() {
    ++mN;
    return (mN % 3 == 0) ? Z.TWO.multiply(mSeq.next()) : mSeq.next();
  }
}
