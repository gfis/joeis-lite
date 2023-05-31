package irvine.oeis.a358;
// Generated by gen_seq4.pl linmangf/lingf at 2023-05-01 21:07

import irvine.oeis.recur.GeneratingFunctionSequence;

/**
 * A358655 a(n) is the number of distinct scalar products which can be formed by pairs of signed permutations (V, W) of [n].
 * @author Georg Fischer
 */
public class A358655 extends GeneratingFunctionSequence {

  /** Construct the sequence. */
  public A358655() {
    super(0, "[1,-2,5,4,0,-15,16,-5]", "[1,-4,6,-4,1]");
  }
}
