package irvine.oeis.a309;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.PrependSequence;
import irvine.oeis.a010.A010062;

/**
 * A309674 a(1) = 1, a(n) = hamming_weight(Sum_{k=1..n-1} a(k) ) for n&gt;=2.
 * @author Sean A. Irvine
 */
public class A309674 extends DifferenceSequence {

  /** Construct the sequence. */
  public A309674() {
    super(1, new PrependSequence(new A010062(), 0));
  }
}
