package irvine.oeis.a165;
// Generated by gen_seq4.pl anopsn 1,0

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a000.A000668;

/**
 * A165223 Products of 2 successive Mersenne primes.
 * @author Georg Fischer
 */
public class A165223 extends AbstractSequence {

  private A000668 mSeq1 = new A000668();
  private Z mA;

  /** Construct the sequence. */
  public A165223() {
    super(1);
    mA = mSeq1.next();
  }

  @Override
  public Z next() {
    final Z b = mSeq1.next();
    final Z result = b.multiply(mA);
    mA = b;
    return result;
  }
}
