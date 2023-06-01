package irvine.oeis.a361;
// Generated by gen_seq4.pl ogf/lingf at 2023-05-27 12:40

import irvine.oeis.recur.GeneratingFunctionSequence;

/**
 * A361203 a(n) = n*A010888(n).
 * @author Georg Fischer
 */
public class A361203 extends GeneratingFunctionSequence {

  /** Construct the sequence. */
  public A361203() {
    super(0, "[0,1,4,9,16,25,36,49,64,81,8,14,18,20,20,18,14,8]", "[1,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,1]");
  }
}