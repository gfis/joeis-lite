package irvine.oeis.a055;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.a003.A003188;

/**
 * A055975 First differences of A003188 (decimal equivalent of the Gray Code).
 * @author Georg Fischer
 */
public class A055975 extends DifferenceSequence {

  /** Construct the sequence. */
  public A055975() {
    super(1, new A003188());
  }
}
