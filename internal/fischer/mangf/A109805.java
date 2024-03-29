package irvine.oeis.a109;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.a006.A006094;

/**
 * A109805 a(n) = prime(n+2)*prime(n+1) - prime(n)*prime(n+1).
 * @author Georg Fischer
 */
public class A109805 extends DifferenceSequence {

  /** Construct the sequence. */
  public A109805() {
    super(1, new A006094());
  }
}
