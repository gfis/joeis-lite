package irvine.oeis.a303;
// Generated by gen_seq4.pl genet at 2020-12-13 00:09
// DO NOT EDIT here!

import irvine.math.z.Z;
import irvine.oeis.GeneralizedEulerTransform;

/**
 * A303130 Expansion of Product_{n>=1} (1 + (9*x)^n)^(-1/3).
 * @author Georg Fischer
 */
public class A303130 extends GeneralizedEulerTransform {

  /** Construct the sequence. */
  public A303130() {
    super(0, 1);
  }

  @Override
  protected Z[] advanceF(final int k) {
    return new Z[] { Z.ONE, Z.THREE };
  }

  @Override
  protected Z advanceG(final int k) {
    return Z.NINE.pow(k).negate();
  }

  @Override
  protected Z advanceH(final int k) {
    return Z.valueOf(k);
  }

}