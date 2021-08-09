package irvine.oeis.a132;
// manually 2020-11-05

import irvine.oeis.EulerTransform;
import irvine.oeis.PeriodicSequence;


/**
 * A132040 McKay-Thompson series of class 10B for the Monster group with a(0) = -4.
 * @author Georg Fischer
 */
public class A132040 extends EulerTransform {

  /** Construct the sequence. */
  public A132040() {
    super(new PeriodicSequence(-4,0,-4,0,-8,0,-4,0,-4,0), 1);
  }
}
