package irvine.oeis.a119;
// Generated by gen_seq4.pl bindec at 2021-08-04 21:56

import irvine.oeis.CharacteristicFunction;
import irvine.oeis.PrependSequence;
import irvine.oeis.a003.A003151;
import irvine.oeis.cons.BinaryToDecimalExpansionSequence;

/**
 * A119809 Decimal expansion of the constant defined by binary sums involving Beatty sequences: c = Sum_{n&gt;=1} 1/2^A049472(n) = Sum_{n&gt;=1} A001951(n)/2^n.
 * @author Georg Fischer
 */
public class A119809 extends PrependSequence {

  /** Construct the sequence. */
  public A119809() {
    super(1, new BinaryToDecimalExpansionSequence(new CharacteristicFunction(new A003151())), 2);
  }
}
