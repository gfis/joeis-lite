package irvine.oeis.a308;
// Generated by gen_seq4.pl knest/jaguarz at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a001.A001008;

/**
 * A308967 Number of prime factors (with multiplicity) of the numerator A001008 of the harmonic number H(n) = Sum_{k=1..n} 1/k.
 * @author Georg Fischer
 */
public class A308967 extends A001008 {
  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).bigOmega());
  }
}
