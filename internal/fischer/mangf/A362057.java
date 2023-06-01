package irvine.oeis.a362;
// Generated by gen_seq4.pl ogf/lingf at 2023-05-27 12:40

import irvine.oeis.recur.GeneratingFunctionSequence;

/**
 * A362057 Number of compositions of n that are anti-palindromic modulo 3.
 * @author Georg Fischer
 */
public class A362057 extends GeneratingFunctionSequence {

  /** Construct the sequence. */
  public A362057() {
    super(0, "[1,0,0,-1]", "[1,-1,0,-3,1]");
  }
}