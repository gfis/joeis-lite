package irvine.oeis.a127;
// Generated by gen_seq4.pl knest/jaguarz at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a127.A127989;

/**
 * A127992 Number of distinct prime factors of 2*n^3 - 2*n + 9.
 * @author Georg Fischer
 */
public class A127992 extends A127989 {
  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).omega());
  }
}