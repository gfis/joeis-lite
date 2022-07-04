package irvine.oeis.a210;
// manually prilist at 2022-05-22 21:55

import irvine.math.z.Z;
import irvine.oeis.prime.PrimeConditionListSequence;

/**
 * A210504 Numbers n for which 2*n+5, 4*n+5, 6*n+5, and 8*n+5 are primes.
 * @author Georg Fischer
 */
public class A210504 extends PrimeConditionListSequence {

  /** Construct the sequence */
  public A210504() {
    super(0, 2,+5,4,+5,6,+5,8,+5);
  }
}
