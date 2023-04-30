package irvine.oeis.a069;
// Generated by gen_seq4.pl knest at 2023-03-02 20:46

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a000.A000984;

/**
 * A069113 Squarefree part of C(2n,n), the central binomial numbers: the smallest number such that a(n)*C(2n,n) is a square.
 * @author Georg Fischer
 */
public class A069113 extends A000984 {
  @Override
  public Z next() {
    return Jaguar.factor(super.next()).core();
  }
}