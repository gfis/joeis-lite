package irvine.oeis.a078;
// Generated by gen_seq4.pl knest/jaguarz at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a078.A078310;

/**
 * A078313 Number of distinct prime factors of n*rad(n)+1, where rad=A007947 (squarefree kernel).
 * @author Georg Fischer
 */
public class A078313 extends A078310 {
  @Override
  public Z next() {
    return Z.valueOf(Jaguar.factor(super.next()).omega());
  }
}
