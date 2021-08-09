package irvine.oeis.a042;
// manually

import irvine.math.z.Z;
import irvine.oeis.PositionSequence;
import irvine.oeis.PrependSequence;
import irvine.oeis.Sequence;

/**
 * A042952 The sequence d when b=[ 1,0,1,1,1,... ].
 * @author Georg Fischer
 */
public class A042952 extends PositionSequence {

  protected Sequence mBinary;
  
  /** Construct the sequence. */
  public A042952() {
    this(new A042953());
  }

  /** 
   * Generic constructor with parameter
   * @param seq underlying sequence
   */
  public A042952(final A042953 seq) {
    super(0, new PrependSequence(seq.getBinarySequence(), 1), 1);
    next();
  }
}