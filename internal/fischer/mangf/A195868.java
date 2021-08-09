package irvine.oeis.a195;

import irvine.math.LongUtils;
import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A195868 Positive integers a for which there is a primitive 1-Pythagorean triple (a,b,c) satisfying a<=b.
 * Cf. the definition and list of related sequences in A195770.
 * k-Pythagorean triples are defined by <code>c^2 = a^2 + b^2 + k*a*b</code>.
 * @author Georg Fischer
 */
public class A195868 implements Sequence {
    
  protected long mA; // the shortest leg
  protected long mB; // the leg in the middle
  protected long mC; // the longest leg
  protected int mNum; // numerator of k
  protected int mDen; // denominator of k
  protected int mLeg; // code for the leg: 0 = a, 1 = b, 2 = c
  
  /** 
   * Empty constructor
   */
  public A195868() {
    this(1, 1, 1);
  }
  
  /** 
   * Constructor with k
   * @param kNum numerator of k
   * @param kDen denominator of k
   * @param leg code for the leg: 0 = a, 1 = b, 2 = c
   */
  public A195868(final int kNum, final int kDen, final int leg) {
    mNum = kNum;
    mDen = kDen;
    mLeg = leg;
    mA = 1;
    mB = 1;
    mC = 1;
  }

  @Override
  public Z next() {
    while (true) {
      mB += 2;
      if (mB > mA * mA / 2) {
        ++mA;
        mB = mA + 1;
      }
      if (LongUtils.gcd(mA, mB) == 1) {
        final long c2 = mA * mA + mB * mB;
        mC = LongUtils.sqrt(c2);
        if (mC * mC == c2 && LongUtils.gcd(mC, mA) == 1 && LongUtils.gcd(mC, mB) == 1) {
          switch (mLeg) {
            case 0:
              return Z.valueOf(mA);
            case 1:
              return Z.valueOf(mB);
            case 2:
              return Z.valueOf(mC);
            default:
              return Z.NEG_ONE; // cannot happen
          }
        }
      }
    }
  }
}