package irvine.oeis.a192;

import irvine.math.z.Z;
import irvine.oeis.Sequence1;
import irvine.oeis.SkipSequence;
import irvine.oeis.transform.InverseEulerTransform;
import irvine.oeis.a004.A004016;

/**
 * A192733 Euler transform is sequence A004016.
 * @author Georg Fischer
 */
public class A192733 extends Sequence1 {

  private final InverseEulerTransform mSeq = new InverseEulerTransform(new SkipSequence(new A004016(), 1));
  
  @Override
  public Z next() {
    return mSeq.next();
  }
}
