package irvine.oeis.a265;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.a048.A048701;

/**
 * A265026 First differences of A048701.
 * @author Georg Fischer
 */
public class A265026 extends DifferenceSequence {

  /** Construct the sequence. */
  public A265026() {
    super(1, new A048701());
  }
}
