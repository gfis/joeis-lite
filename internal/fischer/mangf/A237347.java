package irvine.oeis.a237;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.a078.A078633;

/**
 * A237347 First differences of A078633.
 * @author Georg Fischer
 */
public class A237347 extends DifferenceSequence {

  /** Construct the sequence. */
  public A237347() {
    super(1, new A078633());
  }
}