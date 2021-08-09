package irvine.oeis.a038;

import irvine.factor.prime.Fast;
import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A038873 Primes p such that 2 is a square mod p; or, primes congruent to {1, 2, 7} mod 8.
 * @author Georg Fischer
 */
public class A038873 implements Sequence {

  private   final Fast mPrime;
  private   long mP = 2;
  protected long mSquare; // this should be a square mod p
  protected boolean mNegate; // true if it should not be a square mod p

  /** Construct the sequence. */
  public A038873() {
    this(2, false);
  }

  /** Constructor with parameters.
   * @param square this should be a square mod p
   * @param negate true if it should not be a square mod p
   */
  public A038873(final int square, final boolean negate) {
    mP = 2;
    mSquare = square;
    mNegate = negate;
    mPrime = new Fast();
  }

  @Override
  public Z next() {
    while (true) {
      mP = mPrime.nextPrime(mP);
      System.out.println("prime: " + mP);
      if ((LongUtils.jacobi(mSquare, mP) == -1) ^ negate) {
        return Z.valueOf(mP);
      }
    }
  }
}
