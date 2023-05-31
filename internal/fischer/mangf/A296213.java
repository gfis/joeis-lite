package irvine.oeis.a296;
// Generated by gen_seq4.pl robot/charfun at 2023-05-04 21:32
// DO NOT EDIT here!

import irvine.oeis.CharacteristicFunction;
import irvine.oeis.a063.A063532;
/**
 * A296213 a(n) = 1 if both 1+phi(k) and 1+sigma(k) are squares, 0 otherwise.
 * @author Georg Fischer
 */
public class A296213 extends CharacteristicFunction {

  /** Construct the sequence. */
  public A296213() {
    super(1, new A063532());
  }
}
