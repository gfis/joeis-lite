package irvine.oeis.a362;
// Generated by gen_seq4.pl ogf/lingf at 2023-05-27 12:40

import irvine.oeis.recur.GeneratingFunctionSequence;

/**
 * A362298 Number of tilings of a 4 X n rectangle using dominos and 2 X 2 right triangles.
 * @author Georg Fischer
 */
public class A362298 extends GeneratingFunctionSequence {

  /** Construct the sequence. */
  public A362298() {
    super(0, "[1,-3,-3,9]", "[1,-4,-18,48,42,-99]");
  }
}