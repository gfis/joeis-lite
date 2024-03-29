package irvine.oeis.a280;
// generated by patch_offset.pl at 2023-06-16 18:44

import irvine.oeis.PartialProductSequence;
import irvine.oeis.a206.A206032;

/**
 * A280086 Partial products of A206032 (Product_{d|n} sigma(d)).
 * @author Georg Fischer
 */
public class A280086 extends PartialProductSequence {

  /** Construct the sequence. */
  public A280086() {
    super(1, new A206032());
  }
}
