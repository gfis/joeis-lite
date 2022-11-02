package irvine.oeis.a195;
// Generated by gen_seq4.pl insect/union3 at 2022-02-24 19:57

import irvine.oeis.UnionSequence;
import irvine.oeis.a001.A001318;
import irvine.oeis.a032.A032528;
import irvine.oeis.a045.A045943;

/**
 * A195060 Numbers on the main diagonals and on the axes (x,y) in the square spiral whose vertices are the generalized pentagonal numbers A001318.
 * @author Georg Fischer
 */
public class A195060 extends UnionSequence {

  /** Construct the sequence. */
  public A195060() {
    super(new A001318(), new A032528(), new A045943());
    mOffset = 0;
  }
}