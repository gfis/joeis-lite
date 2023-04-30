package irvine.oeis.a069;
// Generated by gen_seq4.pl knest/jaguarz at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a000.A000217;

/**
 * A069904 Number of prime factors of n-th triangular number (with multiplicity).
 * @author Georg Fischer
 */
public class A069904 extends A000217 {

  {
    super.next();
  }
   
  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).bigOmega());
  }
}