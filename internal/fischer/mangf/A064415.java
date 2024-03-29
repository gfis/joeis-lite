package irvine.oeis.a064;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.PrependSequence;
import irvine.oeis.a053.A053044;

/**
 * A064415 a(1) = 0, a(n) = iter(n) if n is even, a(n) = iter(n)-1 if n is odd, where iter(n) = A003434(n) = smallest number of iterations of Euler totient function phi needed to reach 1.
 * @author Sean A. Irvine
 */
public class A064415 extends DifferenceSequence {

  /** Construct the sequence. */
  public A064415() {
    super(1, new PrependSequence(new A053044(), 0));
  }
}
