package irvine.oeis.a304;
// Generated by gen_seq4.pl dirichcon/dirichinv at 2023-06-04 22:05

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.DirichletInverseSequence;
import irvine.oeis.a304.A304819;

/**
 * A304820 A co-delta function for non-perfect powers. Dirichlet inverse of A304819.
 * @author Georg Fischer
 */
public class A304820 extends AbstractSequence {

  private final DirichletInverseSequence mSeq = new DirichletInverseSequence(new A304819());

  /** Construct the sequence. */
  public A304820() {
    super(1);
  }

  @Override
  public Z next() {
    return mSeq.next();
  }
}