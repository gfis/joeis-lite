package irvine.oeis.a063;
// Generated by gen_seq4.pl sigman0/sigma0 at 2023-02-28 16:47

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a002.A002477;

/**
 * A063750 Number of divisors (A000005) of the Wonderful Demlo numbers A002477.
 * @author Georg Fischer
 */
public class A063750 extends A002477 {

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma0();
  }
}