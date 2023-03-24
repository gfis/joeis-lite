package irvine.oeis.a265;

import irvine.factor.prime.Fast;
import irvine.math.z.Z;
import irvine.oeis.MultiplicativeSequence;

/**
 * A265398 Perform one x^2 -&gt; x+1 reduction for the polynomial with nonnegative integer coefficients 
 * that is encoded in the prime factorization of n.
 * @author Georg Fischer
 */
public class A265398 extends MultiplicativeSequence {

  private long mN = 0;
  private final static Fast mPrime = new Fast();

  /** Construct the sequence. */
  public A265398() {
    super(1, (p, e) -> mPrime.prevPrime(p).multiply(mPrime.prevPrime(mPrime.prevPrime(p))).pow(e));
    super.next();
    super.next();
    super.next();
  }

  @Override
  public Z next() {
    ++mN;
    return (mN <= 3) ? Z.valueOf(mN) : super.next();
  }
}
