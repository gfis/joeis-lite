package irvine.oeis.a066;
// manually deris/essent at 2021-12-09 19:40

import irvine.oeis.PrependSequence;
import irvine.oeis.a035.A035095;

/**
 * A066674 Least number m such that phi(m) = A000010(m) is divisible by the n-th prime.
 * @author Georg Fischer
 */
public class A066674 extends PrependSequence {

  /** Construct the sequence. */
  public A066674() {
    super(0, new A035095());
  }
}
