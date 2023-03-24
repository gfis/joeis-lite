package irvine.oeis.a200;

import irvine.factor.prime.Fast;
import irvine.math.z.Z;
import irvine.oeis.MultiplicativeSequence;

/**
 * A200746 Completely multiplicative function with a(prime(k)) = prime(k)*prime(k-1), a(2) = 2.
 * @author Georg Fischer
 */
public class A200746 extends MultiplicativeSequence {

  private long mN = 0;
  private final static Fast mPrime = new Fast();

  /** Construct the sequence. */
  public A200746() {
    super(1, (p, e) -> p.multiply(mPrime.prevPrime(p)).pow(e));
    super.next();
    super.next();
  }

  @Override
  public Z next() {
    ++mN;
    return (mN <= 2) ? Z.valueOf(mN) : super.next();
  }
}
