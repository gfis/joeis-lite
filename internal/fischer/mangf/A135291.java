package irvine.oeis.a135;
// Generated by gen_seq4.pl sigman0/sigma0 at 2023-02-28 16:47

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a049.A049614;

/**
 * A135291 Product of the nonzero exponents in the prime factorization of n!.
 * @author Georg Fischer
 */
public class A135291 extends A049614 {

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma0();
  }
}