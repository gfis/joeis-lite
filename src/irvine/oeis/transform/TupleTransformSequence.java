package irvine.oeis.transform;

import java.util.function.BiFunction;

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.AbstractSequence;
import irvine.oeis.Sequence;

/**
 * A sequence comprising the transform of a tuple of other sequences.
 * This program is similar to {@link TupleTransformSequence}, but the terms
 * of several underlying sequence can be used in the lambda expression:
 * @author Georg Fischer
 */
public class TupleTransformSequence extends AbstractSequence {

  private final BiFunction<Integer, Z[], Z> mLambda; // (n, s) -> f(n, s[0], s[1] ...)
  private final Sequence[] mSeqs; // underlying source sequences s[0], s[1] ..
  private final int mSeqNo; // number of underlying sequences s[i]
  private final Z[] mTerms; // terms of s[i]
  private final Z[] mPrevs; // previous terms of s[i]
  private final Z[] mInits; // initial terms
  private final int mInitNo; // mInits.length
  private int mIn; // index for mInits
  private int mN; // current index of target sequence a(n)

  /** Pairing function <code>(t, u) -&gt; ((t + u)^2 + 2 - t - 3*u) / 2</code>. */
  // u.add(v).square().add(2).subtract(u).subtract(v.multiply(3)).divide2();
  public static final BiFunction<Integer, Z[], Z> PAIR = (n, s) -> s[0].add(s[1]).square().add(2).subtract(s[0]).subtract(s[1].multiply(3)).divide2();
  /** Increment: terms + 1 */
  public static final BiFunction<Integer, Z[], Z> INC = (n, s) -> s[0].add(s[1]);
  /** Decrement: terms - 1 */
  public static final BiFunction<Integer, Z[], Z> DEC = (n, s) -> s[0].subtract(s[1]);
  /** Double: terms * 2 */
  public static final BiFunction<Integer, Z[], Z> DOUBLE = (n, s) -> s[0].add(s[1]);
  /** Halve: terms / 2 */
  public static final BiFunction<Integer, Z[], Z> HALVE = (n, s) -> s[0].subtract(s[1]);

  /**
   * Creates a simple transform of an existing sequence.
   * @param offset offset of new sequence
   * @param lambda function mapping (n,v) to the term of the target sequence
   * @param initTerms initial terms for a(n)
   * @param seqs underlying source sequences v0, v1, v2 and so on
   * A typical pattern for the call is:
   * <code>super(1, (n, s) -> f(n, s[0], s[1], s[2]), "1", new A999990(), new A999991(), new A999992())</code>
   * The terms of the underlying sequences are accessed by s[0], s[1] and so on.
   * If there are some initial terms, the underlying sequences are NOT evaluated for the first few indexes of a(n),
   * and those sequences must be skipped accordingly.
   * In general, the indexes n of a(n) and of s[0](n), s[1](n) and so on must be aligned carefully.
   */
  public TupleTransformSequence(final int offset, final BiFunction<Integer, Z[], Z> lambda, final String initTerms, final Sequence... seqs) {
    super(offset);
    mN = offset - 1;
    mIn = -1;
    mLambda = lambda;
    mSeqs = seqs;
    mSeqNo = mSeqs.length;
    mTerms = new Z[mSeqNo];
    mInits = (initTerms.isEmpty() || "[]".equals(initTerms)) ? new Z[0] : ZUtils.toZ(initTerms);
    mInitNo = mInits.length;
  }

  @Override
  public Z next() {
    ++mN;
    ++mIn;
    if (mIn < mInitNo) {
      return mInits[mIn];
    }
    for (int it = 0; it < mSeqNo; ++it) {
      mTerms[it] = mSeqs[it].next();
    }
    return mLambda.apply(mN, mTerms);
  }
}
