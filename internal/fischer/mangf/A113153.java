package irvine.oeis.a113;
// manually partsumm/partsum at 2022-04-12

import irvine.oeis.SkipSequence;
import irvine.oeis.a000.A000073;

/**
 * A113153 Sum of the first n tribonacci numbers, in ascending order, as bases, with the same, in descending order, as exponents.
 * @author Georg Fischer
 */
public class A113153 extends A113122 {

  /** Construct the sequence. */
  public A113153() {
    super(new SkipSequence(new A000073(), 1));
  }
}
