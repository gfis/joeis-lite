package irvine.oeis.a099;
// Generated by gen_seq4.pl charfun at 2020-08-28 13:59
// DO NOT EDIT here!

import irvine.oeis.CharacteristicFunction;
import irvine.oeis.a007.A007283;

/**
 * A099395 One if odd part of n is 3, zero otherwise.
 * @author Georg Fischer
 */
public class A099395 extends CharacteristicFunction {

  /** Construct the sequence. */
  public A099395() {
    super(0, new A007283());
    next();
  }

  @Override
  public int getOffset() {
    return 1;
  }
}
