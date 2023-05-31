package irvine.oeis.a247;
// Generated by gen_seq4.pl interleave at 2023-04-16 17:12

import irvine.oeis.AlternatingSequence;
import irvine.oeis.a000.A000861;
import irvine.oeis.a247.A247359;

/**
 * A247362 Interleave A000861 and A247359, numbers ending in a vowel resp. consonant in English.
 * @author Georg Fischer
 */
public class A247362 extends AlternatingSequence {

  /** Construct the sequence. */
  public A247362() {
    super(0, new A000861(), new A247359());
  }
}
