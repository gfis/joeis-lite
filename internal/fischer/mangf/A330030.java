package irvine.oeis.a330;
// Generated by gen_seq4.pl knest/jaguar at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a061.A061355;

/**
 * A330030 Least k such that Sum_{i=0..n} k^n / i! is a positive integer.
 * @author Georg Fischer
 */
public class A330030 extends A061355 {
  @Override
  public Z next() {
    return Jaguar.factor(super.next()).squareFreeKernel();
  }
}