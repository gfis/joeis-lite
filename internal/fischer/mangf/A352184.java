package irvine.oeis.a352;

import irvine.math.z.Z;
import irvine.oeis.FiniteSequence;
import irvine.oeis.SequenceWithOffset;

/**
 * A352184 Coxeter-Catalan numbers for the Coxeter groups A_0, A_1, A_2, A_3 = D_3, D_4, D_5, E_6, E_7, E_8.
 * @author Georg Fischer
 */
public class A352184 extends FiniteSequence implements SequenceWithOffset {

  /** Construct the sequence. */
  public A352184() {
    super(new long[] { 1, 2, 5, 14, 50, 182, 833, 4160, 25080 });
  }

  @Override
  public int getOffset() {
    return 0;
  }
}
