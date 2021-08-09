package irvine.oeis.a164;
// Generated by gen_seq4.pl holos at 2021-05-18 15:27
// DO NOT EDIT here!

import irvine.oeis.HolonomicRecurrence;

/**
 * A164203 Number of binary strings of length n with equal numbers of 00001 and 10000 substrings.
 * @author Georg Fischer
 */
public class A164203 extends HolonomicRecurrence {

  /** Construct the sequence. */
  public A164203() {
    super(0, "[[0],[64,-4],[24,-2],[20,-2],[16,-2],[-20,2],[0],[0],[0],[0,2],[0,-1]]", "[1,2,4,8,16,30,58,114,226,452]", 0);
  }
}
