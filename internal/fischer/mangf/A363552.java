package irvine.oeis.a363;
// Generated by gen_seq4.pl amoda

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a008.A008836;
import irvine.oeis.a307.A307430;

/**
 * A363552 M√∂bius function of rank 4: a(n) = lambda(n) = A008836(n) if n is biquadratefree (A046100) and 0 otherwise.
 * @author Georg Fischer
 */
public class A363552 extends AbstractSequence {

  private A008836 mSeq1 = new A008836();
  private A307430 mSeq2 = new A307430();

  /** Construct the sequence. */
  public A363552() {
    super(1);
  }

  @Override
  public Z next() {
    return mSeq1.next().multiply(mSeq2.next());
  }
}