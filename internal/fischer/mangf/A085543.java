package irvine.oeis.a085;
// Generated by gen_seq4.pl sigman0/sigma0 at 2023-02-28 16:47

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a000.A000041;

/**
 * A085543 Number of divisors of the partition numbers (A000041).
 * @author Georg Fischer
 */
public class A085543 extends A000041 {

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma0();
  }
}