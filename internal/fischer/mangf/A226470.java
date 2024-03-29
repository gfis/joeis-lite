package irvine.oeis.a226;
// Generated by gen_seq4.pl amoda

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a000.A000217;
import irvine.oeis.a000.A000290;

/**
 * A226470 a(n) = n^2 XOR triangular(n), where XOR is the bitwise logical exclusive-or operator.
 * @author Georg Fischer
 */
public class A226470 extends AbstractSequence {

  private A000290 mSeq1 = new A000290();
  private A000217 mSeq2 = new A000217();

  /** Construct the sequence. */
  public A226470() {
    super(0);
  }

  @Override
  public Z next() {
    return mSeq1.next().xor(mSeq2.next());
  }
}
