package irvine.oeis.a230;
// Generated by gen_seq4.pl trafo

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.a000.A000120;
import irvine.oeis.transform.BoustrophedonTransformSequence;

/**
 * A230952 Boustrophedon transform of Hamming weight (A000120).
 * @author Georg Fischer
 */
public class A230952 extends AbstractSequence {

  private final BoustrophedonTransformSequence mSeq1 = new BoustrophedonTransformSequence(new A000120());

  /** Construct the sequence. */
  public A230952() {
    super(0);
  }

  @Override
  public Z next() {
    return mSeq1.next();
  }
}
