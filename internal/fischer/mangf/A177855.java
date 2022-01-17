package irvine.oeis.a177;

import irvine.factor.factor.Jaguar;
import irvine.math.z.Z;
import irvine.oeis.FiniteSequence;

/**
 * A177855 Divisors of 2^1092 - 1.
 * @author Sean A. Irvine
 */
public class A177855 extends FiniteSequence {

  /** Construct the sequence. */
  public A177855() {
    super(Jaguar.factor(Z.ONE.shiftLeft(1092).subtract(1)).divisorsSorted());
  }
}

