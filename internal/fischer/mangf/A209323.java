package irvine.oeis.a209;
// Generated by gen_seq4.pl knest/jaguarz at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a014.A014612;

/**
 * A209323 Values of omega(n) (A001221) as n runs through the triprimes (A014612).
 * @author Georg Fischer
 */
public class A209323 extends A014612 {
  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).omega());
  }
}
