package irvine.oeis.a296;
// manually verified, 2023-04-29 (Spezia)

import irvine.oeis.recur.GeneratingFunctionSequence;

/**
 * A296160 Sum of the larger parts of the partitions of n into two parts such that the smaller part is even.
 * @author Georg Fischer
 */
public class A296160 extends GeneratingFunctionSequence {

  /** Construct the sequence. */
  public A296160() {
    super(1, new long[] {0, 0, 0, 0, 2, 1, 1, 1, 1}, new long[] {1, -1, 0, 0, -2, 2, 0, 0, 1, -1});
  }
}
