package irvine.oeis.a084;
// Generated by gen_seq4.pl knest/jaguar at 2023-03-01 20:54

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.a001.A001694;

/**
 * A084371 Squarefree kernels of powerful numbers (A001694).
 * @author Georg Fischer
 */
public class A084371 extends A001694 {
  @Override
  public Z next() {
    return Jaguar.factor(super.next()).squareFreeKernel();
  }
}