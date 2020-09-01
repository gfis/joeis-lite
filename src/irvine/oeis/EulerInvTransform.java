package irvine.oeis;

import java.util.ArrayList;

import irvine.math.Mobius;
import irvine.math.z.Z;
import irvine.math.z.ZUtils;
/**
 * Apply the inverse Euler transform to some other sequence.
 * The program follows closely the code of the OEIS implementations
 * for Maple (N.J.A. Sloane) and Mathematica (Olivier Gerard),
 * see <a href="https://oeis.org/wiki/Sequence_transforms">Sequence Transforms</a>
 * @author Georg Fischer
 */
public class EulerInvTransform implements Sequence {

  private Sequence mSeq;
  private final ArrayList<Z> mAs = new ArrayList<>(); // underlying sequence
  private final ArrayList<Z> mBs = new ArrayList<>(); // resulting sequence
  private final ArrayList<Z> mCs = new ArrayList<>(); // auxiliary sequence
  protected Z[] mPreTerms; // initial terms to be prepended
  protected int mIn; // index for initial terms
  protected int mN;

  /**
   * Empty constructor;
   * initializes the internal properties
   */
  public EulerInvTransform() {
    mIn = 0;
    mN = 0;
    mAs.add(Z.ZERO); // [0] is not returned
    mBs.add(Z.ZERO); // [0] not used
    mCs.add(Z.ZERO); // [0] starts the sum
    mPreTerms = new Z[] { }; // no prefix terms
  }

  /**
   * Create a new sequence with no additional terms at the front.
   * @param seq main sequence
   */
  public EulerInvTransform(final Sequence seq) {
    this();
    mSeq = seq;
  }

  /**
   * Create the inverse Euler transform of the given sequence,
   * with additional Z terms prepended.
   * @param seq underlying sequence
   * @param preTerms additional terms to be prepended;
   * usually there is a leading one.
   */
  public EulerInvTransform(final Sequence seq, final Z... preTerms) {
    this(seq);
    mPreTerms = preTerms;
  }

  /**
   * Create a new sequence
   * with additional long terms prepended.
   * @param seq main sequence
   * @param preTerms additional terms to be prepended;
   * usually there is a leading one.
   */
  public EulerInvTransform(final Sequence seq, final long... preTerms) {
    this(seq);
    mPreTerms = ZUtils.toZ(preTerms);
  }

  /**
   * Create a new sequence.
   * This constructor is used in most of the generated sequences.
   * @param seqType: (0 = arbitrary), 1 = finite, 2 = periodic, 3 = eventually periodic
   * @param terms finite list of terms
   * @param preTerms additional terms to be prepended;
   * usually there is a leading one.
   */
  public EulerInvTransform(final int seqType, final String terms, final String preTerms) {
    this(seqType, terms, preTerms, 1);
  }

  /**
   * Create a new sequence.
   * This constructor is used in most of the generated sequences.
   * @param seqType: (0 = arbitrary), 1 = finite, 2 = periodic, 3 = eventually periodic
   * @param terms finite list of terms
   * @param preTerms additional terms to be prepended;
   * @param periodLen length of the period
   * usually there is a leading one.
   */
  public EulerInvTransform(final int seqType, final String terms, final String preTerms, final int periodLen) {
    this();
      switch (seqType) {
      case 0:
        mSeq = null;
        break;
      case 1:
        mSeq = new FiniteSequence(ZUtils.toZ(terms));
        break;
      case 2:
        mSeq = new PeriodicSequence(ZUtils.toZ(terms));
        break;
      default:
        throw new RuntimeException("Unexpected sequence type");
      }
    mPreTerms = preTerms.isEmpty() ? new Z[0] : ZUtils.toZ(preTerms);
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
    mN++; // starts with 1
    final Z bNext = mSeq.next();
    mBs.add(bNext == null ? Z.ZERO : bNext); // get next b(n)
    mCs.add(Z.ZERO); // allocate c[n]
    final int i = mN;

    Z cSum = Z.valueOf(i).multiply(mBs.get(i));
    for (int d = 1; d < i; ++d) {
      cSum = cSum.subtract(mCs.get(d).multiply(mBs.get(i - d)));
    } // for d
    mCs.set(i, cSum);

    Z aSum = Z.ZERO;
    for (int d = 1; d <= i; ++d) { // compute c[n] = sum ...
      final int mob = (i % d == 0) ? Mobius.mobius(i / d) : 0; // "mob(i,d)"
      if (mob != 0) {
        aSum = aSum.add(Z.valueOf(mob).multiply(mCs.get(d)));
      }
    } // for d
    aSum = aSum.divide(Z.valueOf(i));
    mAs.add(aSum);
    return aSum;
  }

}
