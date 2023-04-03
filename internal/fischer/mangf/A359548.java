package irvine.oeis.a359;
// Generated by gen_seq4.pl multm/dirichinv at 2023-03-28 18:24

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.DirichletInverseSequence;
import irvine.oeis.a053.A053866;

/**
 * A359548 Dirichlet inverse of A053866, where A053866(n) gives the parity of sigma(n).
 * @author Georg Fischer
 */
public class A359548 extends AbstractSequence {

  private final DirichletInverseSequence mSeq = new DirichletInverseSequence(new A053866());

  /** Construct the sequence. */
  public A359548() {
    super(1);
  }

  @Override
  public Z next() {
    return mSeq.next();
  }
}
