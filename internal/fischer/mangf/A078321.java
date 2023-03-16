package irvine.oeis.a078;
// Generated by gen_seq4.pl knest/eulphi at 2023-03-01 20:54

import irvine.math.z.Euler;
import irvine.math.z.Z;
import irvine.oeis.a078.A078310;

/**
 * A078321 Euler&apos;s totient of n*rad(n)+1, where rad=A007947 (squarefree kernel).
 * @author Georg Fischer
 */
public class A078321 extends A078310 {
  @Override
  public Z next() {
    return Euler.phi(super.next());
  }
}
