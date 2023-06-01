package irvine.oeis.a361;
// Generated by gen_seq4.pl robot/charfun at 2023-05-04 21:32
// DO NOT EDIT here!

import irvine.oeis.CharacteristicFunction;
import irvine.oeis.a057.A057922;
/**
 * A361022 a(n) = 1 if d(n) divides d(n+1), otherwise 0, where d(n) is number of positive divisors of n.
 * @author Georg Fischer
 */
public class A361022 extends CharacteristicFunction {

  /** Construct the sequence. */
  public A361022() {
    super(1, new A057922());
  }
}