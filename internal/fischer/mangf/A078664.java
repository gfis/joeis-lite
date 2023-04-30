package irvine.oeis.a078;
// Generated by gen_seq4.pl sigman0/sigma0 at 2023-02-28 16:47

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a002.A002858;

/**
 * A078664 Number of divisors of the n-th Ulam number.
 * @author Georg Fischer
 */
public class A078664 extends A002858 {

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma0();
  }
}