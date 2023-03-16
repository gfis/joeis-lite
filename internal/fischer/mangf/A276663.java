package irvine.oeis.a276;
// Generated by gen_seq4.pl knest at 2023-03-02 20:46

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a000.A000396;

/**
 * A276663 Sum of primes dividing n-th perfect number (with repetition).
 * @author Georg Fischer
 */
public class A276663 extends A000396 {
  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sopfr();
  }
}
