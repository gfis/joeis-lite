package irvine.oeis;

import irvine.math.z.Z;

/**
 * A sequence derived from one or more other sequences.
 * @author Georg Fischer
 */
public abstract class DerivedSequence implements Sequence {

  protected long mN = 0; 
  
  @Override
  public Z next() {
    return Z.valueOf(mN);
  }
}
