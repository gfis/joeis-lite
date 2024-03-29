package irvine.oeis.a247;
// Generated by gen_seq4.pl knest/jaguar at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a025.A025487;

/**
 * A247451 Largest primorial factor of n-th least product of primorial numbers, cf. A025487.
 * @author Georg Fischer
 */
public class A247451 extends A025487 {
  @Override
  public Z next() {
    return Jaguar.factor(super.next()).squareFreeKernel();
  }
}
