package irvine.oeis.a361;
// Generated by gen_seq4.pl multm/dirichinv at 2023-03-28 18:24

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.DirichletInverseSequence;
import irvine.oeis.a038.A038712;

/**
 * A361019 Dirichlet inverse of A038712.
 * @author Georg Fischer
 */
public class A361019 extends AbstractSequence {

  private final DirichletInverseSequence mSeq = new DirichletInverseSequence(new A038712());

  /** Construct the sequence. */
  public A361019() {
    super(1);
  }

  @Override
  public Z next() {
    return mSeq.next();
  }
}