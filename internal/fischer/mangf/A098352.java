package irvine.oeis.a098;
// Generated by gen_seq4.pl trimultab/parm3 at 2021-11-02 22:33

import irvine.oeis.a005.A005843;
import irvine.oeis.a073.A073060;
/**
 * A098352 Multiplication table of the even numbers read by antidiagonals.
 * @author Georg Fischer
 */
public class A098352 extends A073060 {

  /** Construct the sequence. */
  public A098352() {
    super(1, new A005843(), 1);
  }
}