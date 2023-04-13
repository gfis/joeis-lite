package irvine.oeis.producer;

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;

/**
 * Superclass for Java programs generated from LODA assembler programs.
 * @author Georg Fischer
 */
public class LodaSequence extends AbstractSequence {

  protected int mN; // current index

  /**
   * Construct a sequence backed by a PARI program.
   * @param offset first index
   */
  public LodaSequence(final int offset) {
    super(offset);
    mN = -1; // LODA programs always start with $0 = 0.
  }
}
