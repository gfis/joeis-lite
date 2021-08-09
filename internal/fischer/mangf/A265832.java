package irvine.oeis.a265;
// manually 2020-12-09 14:58

import irvine.math.z.Z;
import irvine.oeis.a016.A016885;
import irvine.oeis.GeneralizedEulerTransform;

/**
 * A265832 Expansion of Product_{k>=1} 1/(1 - (5*k-2)*x^(5*k-2)).
 * @author Georg Fischer
 */
public class A265832 extends GeneralizedEulerTransform {

  /** Construct the sequence. */
  public A265832() {
    super();
/*
    mK = 0;
    mSeqG = new A016885();
    mSeqH = new A016885();
    mHp1 = 3L;
*/
  }

  @Override
  protected Z advanceF(final long k) {
    return Z.ONE;
  }

  @Override
  protected Z advanceG(final long k) {
    // System.out.println("advanceG(" + k + ") = " + mHp1);
    return Z.valueOf(5 * k - 2); // mSeqG.next();
  }

  @Override
  protected long advanceH(final long k) {
    // System.out.println("advanceH(" + k + ") = " + (5 * k - 2));
    // mHp1 += 5;
    return 5 * k - 2;
  }

}
