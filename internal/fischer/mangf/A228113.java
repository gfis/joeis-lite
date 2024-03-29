package irvine.oeis.a228;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.PrependSequence;
import irvine.oeis.a057.A057793;

/**
 * A228113 First differences of A057793.
 * @author Georg Fischer
 */
public class A228113 extends DifferenceSequence {

  /** Construct the sequence. */
  public A228113() {
    super(1, new PrependSequence(0, new A057793(), 0));
  }
}
