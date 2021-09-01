package irvine.oeis.a062;
// manually 2021-08-04

import irvine.factor.factor.Cheetah;
import irvine.factor.util.FactorSequence;
import irvine.math.z.Z;
import irvine.oeis.a003.A003586;
/**
 * A062565 Squarefree parts of 3-smooth numbers.
 * @author Georg Fischer
 */
public class A062565 extends A003586 {

  @Override
  public Z next() {
    return Cheetah.factor(super.next()).squareFreeKernel();
  }
}
