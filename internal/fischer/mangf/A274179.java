package irvine.oeis.a274;
// manually, copied from A247223

import irvine.oeis.EulerTransform;
import irvine.oeis.PeriodicSequence;

/**
 * A274179 Expansion of f(x^1, x^6) in powers of x where f() is Ramanujan's general theta function.
 * @author Georg Fischer
 */
public class A274179 extends EulerTransform {

  /** Construct the sequence. */
  public A274179() {
    super(new PeriodicSequence(1,-1,0,0,0,1,-1,1,0,0,0,-1,1,-1), 1);
  }
}