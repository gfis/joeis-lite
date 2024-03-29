package irvine.oeis.a093;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.a004.A004001;

/**
 * A093879 First differences of A004001.
 * @author Georg Fischer
 */
public class A093879 extends DifferenceSequence {

  /** Construct the sequence. */
  public A093879() {
    super(1, new A004001());
  }
}
