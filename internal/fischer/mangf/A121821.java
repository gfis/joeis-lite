package irvine.oeis.a121;
// generated by patch_offset.pl at 2022-08-27 22:44

import irvine.oeis.PrependSequence;
import irvine.oeis.SkipSequence;
import irvine.oeis.a102.A102460;
import irvine.oeis.cons.BinaryToDecimalExpansionSequence;

/**
 * A121821 Decimal expansion of the Lucas binary number, Sum_{k&gt;0} 1/2^L(k), where L(k) = A000032(k).
 * @author Georg Fischer
 */
public class A121821 extends BinaryToDecimalExpansionSequence {

  /** Construct the sequence. */
  public A121821() {
    super(0, new PrependSequence(new SkipSequence(new A102460(), 3), 1, 0));
  }
}
