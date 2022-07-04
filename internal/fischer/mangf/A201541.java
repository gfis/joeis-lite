package irvine.oeis.a201;
// manually prilist at 2022-05-22 21:55

import irvine.math.z.Z;
import irvine.oeis.prime.PrimeConditionListSequence;

/**
 * A201541 Numbers n such that 12n+5 and 12n+7 are primes.
 * @author Georg Fischer
 */
public class A201541 extends PrimeConditionListSequence {

  /** Construct the sequence */
  public A201541() {
    super(0, 12,+5,12,+7);
  }
}
