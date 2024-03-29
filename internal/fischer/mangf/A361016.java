package irvine.oeis.a361;
// Generated by gen_seq4.pl robot/charfun at 2023-05-04 21:32
// DO NOT EDIT here!

import irvine.oeis.CharacteristicFunction;
import irvine.oeis.a083.A083866;
/**
 * A361016 a(n) = 1 if A004718(n) = 0, otherwise 0, where A004718 is the Danish composer Per N?rg?rd&apos;s &quot;infinity sequence&quot;.
 * @author Georg Fischer
 */
public class A361016 extends CharacteristicFunction {

  /** Construct the sequence. */
  public A361016() {
    super(0, new A083866());
  }
}
