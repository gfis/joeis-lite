package irvine.oeis.a109;

import irvine.math.z.Z;
import irvine.oeis.Sequence;
import irvine.oeis.a000.A000040;
import irvine.oeis.a001.A001358;

/**
 * A109611 Chen primes: primes p such that p + 2 is either a prime or a semiprime.
 * @author Georg Fischer
 */
public class A109611 extends A000040 {

  private Z mSemi;
  private Z mOldPrime;
  private Z mNewPrime;
  private Sequence mSeq;

  /** Construct the sequence. */
  public A109611() {
    mOldPrime = super.next();
    mSeq = new A001358();
    mSemi = mSeq.next();
  }

  @Override
  public Z next() {
    mNewPrime = super.next();
    Z p2 = mOldPrime.add(2);
    while (mSemi.compareTo(p2) < 0) {
      mSemi = mSeq.next();
    }
    System.out.println("@1: p2=" + p2 + ", mOldPrime=" + mOldPrime + ", mNewPrime=" + mNewPrime + ", mSemi=" + mSemi);
    while (!p2.equals(mNewPrime) && !p2.equals(mSemi)) {
      mOldPrime = mNewPrime;
      p2 = mOldPrime.add(2);
      mNewPrime = super.next();
      while (mSemi.compareTo(p2) < 0) {
        mSemi = mSeq.next();
      }
      System.out.println("@2: p2=" + p2 + ", mOldPrime=" + mOldPrime + ", mNewPrime=" + mNewPrime + ", mSemi=" + mSemi);
    }
    final Z result = mOldPrime;
    mOldPrime = mNewPrime;
    return result;
  }
}
