package irvine.oeis.a112;
// manually patched

import irvine.math.z.Z;
import irvine.oeis.EulerTransform;
import irvine.oeis.PeriodicSequence;
import irvine.oeis.Sequence;

/**
 * A112169 McKay-Thompson series of class 14a for Monster.
 * Uses <code>e14b=ecalc([1,1;7,-1],[2,2])</code> from A058506=A with ET[-2,-2,-2,-2,-2,-2,0]-
 * The sequence here is <code>A - 7*q/A</code>.
 *  
 * @author Georg Fischer
 */
public class A112169 implements Sequence {

  protected EulerTransform mET1; // the first sequenc
  protected EulerTransform mET2; // the second sequence
  protected Z mFactor; // multiply the second sequence by this factor before addition
  protected Z mAdd0; // add this constant to the first resulting term
  protected int mN; // current index/offset
  protected int mOffset; // index of first term of the sequence
  
  /** Construct the sequence. */
  public A112169() {
    this(-1,4,1,    -1,-1,-1,0,-1,-1,-2,0,-1,-1,-1,0,-1,-2,-1,0,-1,-1,-1,0,-2,-1,-1,0,-1,-1,-1,0);
  }

  /** 
   * Constructor with parameters. 
   * @param offset index of first term of the sequence
   * @param per1 the terms of the PeriodicSequence to be transformed
   * @param factor multiply the second sequence by this factor
   * @param add0 constant to be added to a(0)
   */
  public A112169(final int offset, final long factor, final long add0, final long ... per1) {
    mET1 = new EulerTransform(new PeriodicSequence(per1), 1);
    long[] per2 = new long[per1.length];
    for (int k = 0; k < per1.length; ++k) {
      per2[k] = - per1[k]; // negate per1
    }
    mET2 = new EulerTransform(new PeriodicSequence(per2), 1);
    mFactor = Z.valueOf(factor);
    mAdd0 = Z.valueOf(add0);
    mOffset = offset;
    mN = offset - 1;
  }
  
  @Override
  public Z next() {
    ++mN; // starts with offset
    Z result = mET1.next();
    if (mN > 0) {
      result = result.add(mET2.next().multiply(mFactor));
    }
    if (mN == 0) {
      result = result.add(mAdd0);
    }
    return result;
  }
  
}
