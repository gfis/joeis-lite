package irvine.oeis.a054;
// manually

import irvine.math.z.Z;
import irvine.oeis.NumericalAronsonSequence;
import irvine.oeis.Sequence;
import irvine.oeis.a000.A000045;

/**
 * A054049 Earliest sequence with a(a(n)) = Fibonacci(n+1).
 * @author Georg Fischer
 */
public class A054049 extends NumericalAronsonSequence {

  /** Construct the sequence. */
  public A054049() {
    super(0, new A000045(), EARLY);
    mSeq.next();
    mSeq.remove(0);
  }
}