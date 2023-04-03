package irvine.oeis.a327;
// manually dirichcon/dirichcon2 at 2023-03-25 19:35

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.DirichletConvolutionSequence;
import irvine.oeis.a000.A000010;
import irvine.oeis.a000.A000142;

/**
 * A327030 a(n) = Sum_{d|n} phi(d)*(n/d)! for n &gt; 0, a(0) = 0.
 * @author Georg Fischer
 */
public class A327030 extends AbstractSequence {

  private final DirichletConvolutionSequence mSeq = new DirichletConvolutionSequence(new A000010(), 1, new A000142(), 0);
  private int mN = 0;

  /** Construct the sequence. */
  public A327030() {
    super(0);
  }

  @Override
  public Z next() {
    return (++mN == 1) ? Z.ZERO : mSeq.next();
  }
}
