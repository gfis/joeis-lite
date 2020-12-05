package irvine.oeis;

import java.util.ArrayList;

import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.a000.A000012; // all 1's

/**
 * Apply the generalized Euler transform to two other sequences f and g, as defined in OEIS A266964:
 * From Seiichi Manyama, Nov 14 2017:
 * A generalized Euler transform.
 * Suppose given two sequences f(k) and g(k), n&gt;0, we define a new sequence a(n), n&gt;=0, <br />
 * by Product_{k&gt;0} (1 - g(k)*x^k)^(-f(k)) = a(0) + a(1)*x + a(2)*x^2 + ... <br />
 * Since Product_{k&gt;0} (1 - g(k)*x^k)^(-f(k)) = exp(Sum_{n&gt;0} (Sum_{d|n} d*f(d)*g(d)^(n/d))*x^n/n),  <br />
 * we see that a(n) is given explicitly by a(n) = (1/n) * Sum_{k=1..n} b(k)*a(n-k) <br />
 * where b(n) = Sum_{d|n} d*f(d)*g(d)^(n/d). <br />
 * The algorithm here uses a monotone increasing function h(k) (default: h(k) := k) such that<br />
 * g(k) := 0 if k != h(k). <br />
 * Examples: <br />
 * 1. If we set g(k) := 1, we get the usual Euler transform. <br />
 * 2. If we set f(k) := - f1(k) and g(k) := -1, we get the weighout transform (cf. A026007). <br />
 * 3. If we set f(k) := - n (A001478) and g(k) := k (A000027), we get A266964. <br />
 * 4. With the default f(k) := g(k) := A000012 (all 1's), we get A000041 (number of partitions of n). <br />
 * @author Georg Fischer
 */
public class GeneralizedEulerTransform implements Sequence {

  protected Sequence mSeqF; // sequence for the exponent of the parenthesis: 1/(1-x^k)^f(k)
  protected Sequence mSeqG; // sequence for the factor of x^k: 1/(1-g(k)*x^k)^f(k)
  protected Sequence mSeqH; // monontone increasing (!) sequence for the exponent of x: 1/(1-g(k)*x^h(k))^f(k)
  private static final int ESTLEN = 16384; // estimated length of arrays
  private final ArrayList<Z> mFs = new ArrayList<>(ESTLEN); // first underlying sequence (Manyama's f(k))
  private final ArrayList<Z> mGs = new ArrayList<>(ESTLEN); // second underlying sequence (Manyama's g(k))
  private final ArrayList<Z> mBs = new ArrayList<>(ESTLEN); // resulting sequence (Manyama's a(n))
  private final ArrayList<Z> mCs = new ArrayList<>(ESTLEN); // auxiliary sequence (Manyama's b(n))
  protected int mHp1; // next term of the sequence h(k)
  protected Z[] mPreTerms; // initial terms to be prepended
  protected int mIn; // index for initial terms
  protected int mK; // current index k >= 1

  /**
   * Empty constructor;
   * initializes the internal properties
   */
  public GeneralizedEulerTransform() {
  	this(new A000012(), new A000012(), new Z[] { });
  }

  /**
   * Create a new sequence with no additional terms at the front.
   * @param seqF first underlying sequence
   * @param seqG second underlying sequence
   */
  public GeneralizedEulerTransform(final Sequence seqF, final Sequence seqG) {
    this(seqF, seqG, new Z[] { });
  }

  /**
   * Create a new sequence with additional terms at the front.
   * @param preTerms additional terms to be prepended;
   */
  public GeneralizedEulerTransform(final long... preTerms) {
    this(new A000012(), new A000012(), preTerms);
  }

  /**
   * Create the Euler transform of the given sequence,
   * with additional Z terms prepended.
   * @param seqF first underlying sequence
   * @param seqG second underlying sequence
   * @param preTerms additional terms to be prepended;
   * usually there is a leading one.
   */
  public GeneralizedEulerTransform(final Sequence seqF, final Sequence seqG, final Z... preTerms) {
    mIn = 0; // for prepending
    mK = 0;
    mHp1 = advanceH(mK + 1); // always
    mFs.add(Z.ZERO); // [0] not used
    mGs.add(Z.ZERO); // [0] not used
    mBs.add(Z.ZERO); // [0] is not returned
    mCs.add(Z.ZERO); // [0] starts the sum
    mSeqF = seqF;
    mSeqG = seqG;
    mPreTerms = preTerms;
  }

  /**
   * Create a new sequence
   * with additional long terms prepended.
   * @param seqF first underlying sequence
   * @param seqG second underlying sequence
   * @param preTerms additional terms to be prepended;
   * usually there is a leading one.
   */
  public GeneralizedEulerTransform(final Sequence seqF, final Sequence seqG, final long... preTerms) {
    this(seqF, seqG);
    mPreTerms = ZUtils.toZ(preTerms);
  }

  /**
   * Return a term.
   * @return the next term of the transformed sequence.
   */
  @Override
  public Z next() {
    if (mIn < mPreTerms.length) { // during prepend phase
      return mPreTerms[mIn++];
    }
    // normal, transform terms
    ++mK; // starts with 1
    final Z fNext = advanceF(mK);
    mFs.add(fNext == null ? Z.ZERO : fNext); // get next f(k), care for finite f returning null
    final Z gNext = advanceG(mK);
    if (mK < mHp1) { // do not yet stop
      mGs.add(Z.ZERO);
    } else { // stop and continue
      mGs.add(gNext == null ? Z.ZERO : gNext); // get next g(k), care for finite g returning null
      mHp1 = advanceH(mK + 1); // next stop value
    }
    mCs.add(Z.ZERO); // allocate c[n]
    final int i = mK;
    Z cSum = Z.ZERO; // start sum
    for (int d = 1; d <= i; ++d) { // compute c[k] = sum ...
      if (i % d == 0) { // "did(i,d)"
        final int idd = i / d;
        final Z fTerm = mFs.get(d);
        if (! fTerm.isZero()) { // ends in zero for all finite f(k)
          Z cTerm = fTerm.multiply(d);
          final Z gTerm = mGs.get(d);
          if (! gTerm.isZero()) {
            //---- start of the generalization
            if (! gTerm.equals(Z.ONE)) { // != 1
              if (gTerm.equals(Z.NEG_ONE)) {
                if ((idd & 1) != 0) { // *(-1)^odd
                  cTerm = cTerm.negate();
                } // (-1)^even: ignore
              } else { // != -1
                cTerm = cTerm.multiply(gTerm.pow(idd));
              }
            } // else *1^(...): ignore
            //---- end of generalization
            cSum = cSum.add(cTerm);
          } // else g(k) = 0: ignore
        } // else f(k) = 0: ignore
      } // else not "did(i,d)"
    } // for d
    mCs.set(i, cSum); // = c[k]
    Z bSum = mCs.get(i);
    for (int d = 1; d < i; ++d) {
      bSum = bSum.add(mCs.get(d).multiply(mBs.get(i - d)));
    } // for d
    bSum = bSum.divide(i);
    mBs.add(bSum);
    return bSum;
  }

  /**
   * Wrapper around <code>mSeqF.next()</code>, typically overwritten by a subclass.
   * @param k current index, exponent of x
   * @return next term of the underlying sequence f in the definition of the transform
   */
  protected Z advanceF(final int k) {
    return Z.ONE;
  }

  /**
   * Wrapper around <code>mSeqG.next()</code>, may be overwritten by a subclass.
   * @param k current index, exponent of x
   * @return next term of the underlying sequence g in the definition of the transform
   */
  protected Z advanceG(final int k) {
    return Z.ONE;
  }

  /**
   * Wrapper around <code>mSeqH.next()</code>, may be overwritten by a subclass.
   * This sequence most be monotone increasing.
   * @param k current index, exponent of x.
   * int is sufficient here since in the OEIS we assume that indexes (exponents of x) remain &lt; 10^6.
   * @return next term of the underlying sequence h in the definition of the transform
   */
  protected int advanceH(final int k) {
    return k;
  }

}
