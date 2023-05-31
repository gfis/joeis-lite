package irvine.oeis.a333;
// Generated by gen_seq4.pl robot/partsum at 2023-05-04 21:32

import irvine.oeis.PartialSumSequence;
import irvine.oeis.a333.A333169;

/**
 * A333170 a(n) = Sum_{k=0..n} phi(k^2 + 1), where phi is the Euler totient function (A000010).
 * @author Georg Fischer
 */
public class A333170 extends PartialSumSequence {

  /** Construct the sequence. */
  public A333170() {
    super(0, new A333169());
  }
}
