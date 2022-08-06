package irvine.oeis.a210;
// manually prilist at 2022-05-22 21:55

import irvine.math.z.Z;
import irvine.oeis.prime.PrimeConditionListSequence;

/**
 * A210505 Numbers n for which 2*n+7, 4*n+7, 6*n+7, 8*n+7, 10*n+7 and 12*n+7 are primes.
 * @author Georg Fischer
 */
public class A210505 extends PrimeConditionListSequence {

  /** Construct the sequence */
  public A210505() {
    super(0, 2,+7,4,+7,6,+7,8,+7,10,+7,12,+7);
  }
}