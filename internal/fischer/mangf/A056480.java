package irvine.oeis.a056;
// manually A060164/parm2 at 2022-03-25 13:04

import irvine.oeis.PrependSequence;
import irvine.oeis.a056.A056271;
import irvine.oeis.a056.A056471;

/**
 * A056480 Number of primitive (aperiodic) palindromic structures using a maximum of six different symbols.
 * @author Georg Fischer
 */
public class A056480 extends PrependSequence {

  /** Construct the sequence. */
  public A056480() {
    super(new A056271(new A056471()), 1);
  }
}
