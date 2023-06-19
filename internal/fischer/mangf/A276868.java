package irvine.oeis.a276;
// Generated by gen_seq4.pl diffseq at 2023-05-31 14:20

import irvine.oeis.DifferenceSequence;
import irvine.oeis.a276.A276855;

/**
 * A276868 First differences of the Beatty sequence A276855 for 3 + tau, where tau = golden ratio = (1 + sqrt(5))/2.
 * @author Georg Fischer
 */
public class A276868 extends DifferenceSequence {

  /** Construct the sequence. */
  public A276868() {
    super(1, new A276855());
  }
}