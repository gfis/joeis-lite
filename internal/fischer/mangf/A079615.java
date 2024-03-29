package irvine.oeis.a079;
// Generated by gen_seq4.pl knest/jaguar at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a056.A056831;

/**
 * A079615 Product of all distinct prime factors of all composite numbers between n-th prime and next prime.
 * @author Georg Fischer
 */
public class A079615 extends A056831 {
  @Override
  public Z next() {
    return Jaguar.factor(super.next()).squareFreeKernel();
  }
}
