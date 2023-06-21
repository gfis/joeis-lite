package irvine.oeis.a132;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.PrependSequence;
import irvine.oeis.a045.A045844;

/**
 * A132137 a(1)=1, a(n)=maximal digit of sum a(1)+...+a(n-1).
 * @author Sean A. Irvine
 */
public class A132137 extends DifferenceSequence {

  /** Construct the sequence. */
  public A132137() {
    super(1, new PrependSequence(new A045844(), 0));
  }
}