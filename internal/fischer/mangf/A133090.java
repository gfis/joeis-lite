package irvine.oeis.a133;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.PrependSequence;
import irvine.oeis.a309.A309805;

/**
 * A133090 A133081 * [1,2,3,...].
 * @author Sean A. Irvine
 */
public class A133090 extends DifferenceSequence {

  /** Construct the sequence. */
  public A133090() {
    super(1, new PrependSequence(new A309805(), 0));
  }
}