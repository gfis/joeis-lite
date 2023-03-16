package irvine.oeis.a212;
// Generated by gen_seq4.pl sigman0/sigma0 at 2023-02-28 16:47

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a181.A181800;

/**
 * A212640 Number of divisors of A181800(n) (n-th powerful number that is the first integer of its prime signature).
 * @author Georg Fischer
 */
public class A212640 extends A181800 {

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma0();
  }
}
