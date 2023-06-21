package irvine.oeis.a076;
// generated by patch_offset.pl at 2023-06-16 18:44

import irvine.oeis.triangle.RowSumSequence;

/**
 * A076015 Sum of the (n-1)-th powers of the first n integers.
 * @author Georg Fischer
 */
public class A076015 extends RowSumSequence {

  /** Construct the sequence. */
  public A076015() {
    super(1, new A076014());
  }
}