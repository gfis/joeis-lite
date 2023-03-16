package irvine.oeis.a078;
// Generated by gen_seq4.pl knest/jaguar at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a055.A055394;

/**
 * A078386 Squarefree kernels of numbers which can be written as sum of a positive square and a positive cube.
 * @author Georg Fischer
 */
public class A078386 extends A055394 {
  @Override
  public Z next() {
    return Jaguar.factor(super.next()).squareFreeKernel();
  }
}
