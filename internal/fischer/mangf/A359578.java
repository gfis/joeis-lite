package irvine.oeis.a359;
// Generated by gen_seq4.pl multm/dirichinv at 2023-03-28 18:24

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.DirichletInverseSequence;
import irvine.oeis.a336.A336477;

/**
 * A359578 Dirichlet inverse of A336477, where A336477(n) = 1 if phi(n) is a power of 2, otherwise 0.
 * @author Georg Fischer
 */
public class A359578 extends AbstractSequence {

  private final DirichletInverseSequence mSeq = new DirichletInverseSequence(new A336477());

  /** Construct the sequence. */
  public A359578() {
    super(1);
  }

  @Override
  public Z next() {
    return mSeq.next();
  }
}
