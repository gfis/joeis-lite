package irvine.oeis.a113;

import irvine.math.z.Z;
import irvine.oeis.recur.PeriodicSequence;
import irvine.oeis.transform.InverseMobiusTransformSequence;

/**
 * A113062 Expansion of theta series of hexagonal net with respect to a node.
 * @author Georg Fischer
 */
public class A113062 extends InverseMobiusTransformSequence {

  private int mN = -1;
  
  /** Construct the sequence. */
  public A113062() {
    super(new PeriodicSequence(3, -3, 3, 3, -3, -3, 3, -3, 0), 0);
    super.next();
  }

  public Z next() {
    ++mN;
    return (mN == 0) ? Z.ONE : super.next();
  }
}
