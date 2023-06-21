package irvine.oeis.a145;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.a007.A007501;

/**
 * A145272 First differences of successive iterated triangular numbers.
 * @author Georg Fischer
 */
public class A145272 extends DifferenceSequence {

  /** Construct the sequence. */
  public A145272() {
    super(1, new A007501());
  }
}