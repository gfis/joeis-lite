package irvine.oeis.prime;

import irvine.factor.prime.Fast;
import irvine.math.LongUtils;
import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A sequence of primes p that are (not) squares mod k.
 * Adapted from A038873: numbers k that are (not) squares mod p.
 * @author Georg Fischer
 */
public class SquareForm implements Sequence {

  private final Fast mFast;
  private Z mP; // current prime number
  protected Z mModulus; // this should be a square mod p
  protected int mPolar; // +1 if mSquare should be a square mod p, -1 if not

  /**
   * Constructor with parameters.
   * @param modulus the prime p should be a square mod modulus
   * @param polar +1 if mSquare should be a square mod p, -1 if not
   */
  public SquareForm(final int modulus, final int polar) {
    mP = Z.ONE;
    mModulus = Z.valueOf(modulus);
    mPolar = polar == 1 ? 1 : -1;
    mFast = new Fast();
  }

  @Override
  public Z next() {
    while (true) {
      mP = mFast.nextPrime(mP);
      if (mP.jacobi(mModulus) == mPolar) {
        return mP;
      }
    }
  }
}
