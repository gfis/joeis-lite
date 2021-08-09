package irvine.oeis.a101;
// manually 2021-01-20

import irvine.factor.factor.Jaguar;
import irvine.factor.util.FactorSequence;
import irvine.math.z.Z;
import irvine.oeis.HolonomicRecurrence;

/**
 * A101758 Semiprime tribonacci numbers.
 * @author Georg Fischer
 */
public class A101758 extends HolonomicRecurrence {

  protected long mN;

  /** Construct the sequence */
  public A101758() {
    super(0, "[[0],[1],[1],[1],[-1]]", "[0,1,1]", 0);
  }

  @Override
  public Z next() {
    while (true) {
       final Z mF  = super.next();
       if (Jaguar.factorUpToSemiprime(mF).isSemiprime() == FactorSequence.YES) {
         return mF;
       }
    }
  }
}
