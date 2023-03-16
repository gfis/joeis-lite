package irvine.oeis.a146;
// Generated by gen_seq4.pl sigman0/sigma0 at 2023-02-28 16:47

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a025.A025487;

/**
 * A146288 Number of divisors of the n-th prime signature number (A025487(n)).
 * @author Georg Fischer
 */
public class A146288 extends A025487 {

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma0();
  }
}
