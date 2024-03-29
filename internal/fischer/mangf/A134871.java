package irvine.oeis.a134;
// generated by patch_offset.pl at 2023-06-16 18:44

import irvine.oeis.triangle.RowSumSequence;

/**
 * A134871 a(1) = 1, a(n) = tau(n) + n - 2 for n &gt; 1.
 * @author Georg Fischer
 */
public class A134871 extends RowSumSequence {

  /** Construct the sequence. */
  public A134871() {
    super(1, new A134870());
  }
}
