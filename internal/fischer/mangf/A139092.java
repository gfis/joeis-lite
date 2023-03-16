package irvine.oeis.a139;
// Generated by gen_seq4.pl knest/jaguarz at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a139.A139089;

/**
 * A139092 a(n) = number of distinct prime divisors of (9+prime(n)!)/9.
 * @author Georg Fischer
 */
public class A139092 extends A139089 {
  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).omega());
  }
}
