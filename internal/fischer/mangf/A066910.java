package irvine.oeis.a066;
// generated by patch_offset.pl at 2023-06-16 18:27

import irvine.oeis.DifferenceSequence;
import irvine.oeis.PrependSequence;
import irvine.oeis.a073.A073117;

/**
 * A066910 a(1) = 1; a(n+1) = (sum{k=1 to n} a(k) ) (mod n).
 * @author Sean A. Irvine
 */
public class A066910 extends DifferenceSequence {

  /** Construct the sequence. */
  public A066910() {
    super(1, new PrependSequence(new A073117(), 0));
  }
}
