package irvine.oeis.a280;
// generated by patch_offset.pl at 2023-06-16 18:44

import irvine.oeis.PartialProductSequence;
import irvine.oeis.a029.A029940;

/**
 * A280132 Partial products of A029940 (Product_{d|n} phi(d)).
 * @author Georg Fischer
 */
public class A280132 extends PartialProductSequence {

  /** Construct the sequence. */
  public A280132() {
    super(1, new A029940());
  }
}
