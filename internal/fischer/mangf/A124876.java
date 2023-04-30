package irvine.oeis.a124;
// Generated by gen_seq4.pl knest/jaguarz at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a007.A007408;

/**
 * A124876 Number of prime factors (counted with multiplicity) in factorization of A007408(n).
 * @author Georg Fischer
 */
public class A124876 extends A007408 {
  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).bigOmega());
  }
}