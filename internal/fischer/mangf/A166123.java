package irvine.oeis.a166;
// manually anopan 1,0

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a050.A050932;
import irvine.oeis.a166.A166120;

/**
 * A166123 If n is prime, a(n) = 1; otherwise, a(n) is gcd(n, d) where d is the denominator of the (n-1)-th Bernoulli number.
 * @author Georg Fischer
 */
public class A166123 extends AbstractSequence {

  private A166120 mSeq1 = new A166120();
  private A050932 mSeq2 = new A050932();

  /** Construct the sequence. */
  public A166123() {
    super(1);
  }

  @Override
  public Z next() {
    return mSeq1.next().divide(mSeq2.next());
  }
}
