package irvine.oeis.a078;
// Generated by gen_seq4.pl sigman0/sigma0 at 2023-02-28 19:30

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a078.A078310;

/**
 * A078317 Number of divisors of n*rad(n)+1, where rad=A007947 (squarefree kernel).
 * @author Georg Fischer
 */
public class A078317 extends A078310 {

  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sigma0();
  }
}
