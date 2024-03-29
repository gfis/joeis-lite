package irvine.oeis.a042;
// manually

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A042957 The sequence e when b=[ 1,1,1,0,1,1,... ].
 * @author Georg Fischer
 */
public class A042957 extends A042953 {

  /**
   * This sequence represents the vector <code>b</code> in the OEIS definition.
   */
  protected class seqB57 implements Sequence {
    private int mN;
    public seqB57() {
      mN = 0;
    }
    
    @Override
    public Z next() {
      return ++mN == 4 ? Z.ZERO : Z.ONE;
    }
  } // mSeqB
  
  /** Construct the sequence. */
  public A042957() {
    super();
    mSeqB = new seqB57();
  }

}
