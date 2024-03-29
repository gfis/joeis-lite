package irvine.oeis.a347;
// Generated by gen_seq4.pl multm/dirichinv at 2023-03-28 18:24

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.DirichletInverseSequence;
import irvine.oeis.a347.A347236;

/**
 * A347238 Dirichlet inverse of A347236.
 * @author Georg Fischer
 */
public class A347238 extends AbstractSequence {

  private final DirichletInverseSequence mSeq = new DirichletInverseSequence(new A347236());

  /** Construct the sequence. */
  public A347238() {
    super(1);
  }

  @Override
  public Z next() {
    return mSeq.next();
  }
}
