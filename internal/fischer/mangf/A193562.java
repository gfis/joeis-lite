package irvine.oeis.a193;
// Generated by gen_seq4.pl sigman0/sigma0 at 2023-02-28 21:57

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a002.A002523;

/**
 * A193562 Number of divisors of n^4+1.
 * @author Georg Fischer
 */
public class A193562 extends A002523 {

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma0();
  }
}