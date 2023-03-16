package irvine.oeis.a105;
// manually sigman0/sigma0 at 2023-03-12

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.Sequence0;
import irvine.oeis.a019.A019520;

/**
 * A105388 Number of divisors of concatenated even numbers.
 * @author Georg Fischer
 */
public class A105388 extends Sequence0 {

  private final A019520 mSeq = new A019520();

  @Override
  public Z next() {
    return Jaguar.factor(mSeq.next()).sigma0();
  }
}
