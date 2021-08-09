package irvine.oeis.a000;
// manually, 2020-12-07

import irvine.math.z.Z;
import irvine.oeis.EulerTransform;

/**
 * A000081 Number of unlabeled rooted trees with n nodes (or connected functions with a fixed point).
 * @author Georg Fischer
 */
public class A000081 extends EulerTransform {

  private Z mTerm = null; // previous term
  
  /** Construct the sequence. */
  public A000081() {
    super(0, 1);
  }
 
  @Override
  public Z next() {
    mTerm = super.next();
    return mTerm;
  }

  @Override
  protected Z advance() {
    return mTerm;
  }

}
