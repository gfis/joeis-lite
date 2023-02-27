package irvine.oeis.a139;
// Generated by gen_seq4.pl anopsn 1,1

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a034.A034684;

/**
 * A139084 a(n) = (smallest prime-power among the largest powers dividing n of each prime dividing n) * (smallest prime-power among the largest powers dividing (n+1) of each prime dividing (n+1)).
 * @author Georg Fischer
 */
public class A139084 extends AbstractSequence {

  private A034684 mSeq1 = new A034684();
  private Z mA;

  /** Construct the sequence. */
  public A139084() {
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