package irvine.oeis.a349;
// Generated by gen_seq4.pl dirichcon/dirichcon2 at 2023-05-02 09:37

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.DirichletConvolutionSequence;
import irvine.oeis.a008.A008836;
import irvine.oeis.a126.A126760;

/**
 * A349395 Dirichlet convolution of A126760 with Liouville&apos;s lambda.
 * @author Georg Fischer
 */
public class A349395 extends AbstractSequence {

  private final DirichletConvolutionSequence mSeq = new DirichletConvolutionSequence(new A126760(), 0, new A008836(), 1);

  /** Construct the sequence. */
  public A349395() {
    super(1);
  }

  @Override
  public Z next() {
    return mSeq.next();
  }
}