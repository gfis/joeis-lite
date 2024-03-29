package irvine.oeis.a095;
// Generated by gen_seq4.pl recuf7/holos at 2023-06-02 21:34

import irvine.oeis.recur.HolonomicRecurrence;

/**
 * A095816 Number of permutations of 1..n with no three elements in correct or reverse order.
 * @author Georg Fischer
 */
public class A095816 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A095816() {
    super(0, "[[0],[6,-1],[-8,1],[-13,2],[-3,1],[5,-2],[3,-3],[3,-1],[1]]", "[1,1,2,4,18,92,570,4082]", 0);
  }
}
