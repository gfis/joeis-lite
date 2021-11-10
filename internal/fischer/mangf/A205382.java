package irvine.oeis.a205;
// manually deris2/essent at 2021-11-04

import irvine.oeis.PrependSequence;
import irvine.oeis.a109.A109049;

/**
 * A205382 Duplicate of A109049?  For a guide to related sequences, see A204892.
 * @author Georg Fischer
 */
public class A205382 extends PrependSequence {

  /** Construct the sequence. */
  public A205382() {
    super(1, new A109049());
  }
}
