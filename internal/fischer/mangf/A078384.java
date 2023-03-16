package irvine.oeis.a078;
// Generated by gen_seq4.pl knest at 2023-03-02 20:46

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a055.A055394;

/**
 * A078384 Sum of all prime factors of numbers which can be written as sum of a positive square and a positive cube.
 * @author Georg Fischer
 */
public class A078384 extends A055394 {
  @Override
  public Z next() {
    return Jaguar.factor(super.next()).sopfr();
  }
}
