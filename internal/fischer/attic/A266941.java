package irvine.oeis.a266;
// manually 2020-12-02

import irvine.oeis.GeneralizedEulerTransform;
import irvine.oeis.a000.A000027; // positive integers

/**
 * A266941 Expansion of Product_{k>=1} 1 / (1 - k*x^k)^k.
 * @author Georg Fischer
 */
public class A266941 extends GeneralizedEulerTransform {

  /** Construct the sequence */
  public A266941() {
    super(new A000027(), new A000027(), 1); // f(k)=k, g(k)=k
  }

}
