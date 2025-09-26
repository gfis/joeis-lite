package irvine.oeis.transform;

import java.util.ArrayList;
import java.util.function.Function;

import irvine.math.api.RationalSequence;
import irvine.math.q.Q;
import irvine.math.q.QUtils;
import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.Sequence;

/**
 * Apply the generalized Euler transform to two other sequences f and g, as defined in OEIS A266964:
 * From Seiichi Manyama, Nov 14 2017:
 * A generalized Euler transform.
 * Suppose given two sequences f(k) and g(k), n&gt;0, we define a new sequence a(n), n&gt;=0, <br />
 * by Product_{k&gt;0} (1 - g(k)*x^k)^(-f(k)) = b(0) + b(1)*x + b(2)*x^2 + ... = Sum{n&gt;=0} b(n)*x^n<br />
 * Since Product_{k&gt;=1} (1 - g(k)*x^k)^(-f(k)) = exp(Sum_{n&gt;=1} (Sum_{d|n} d*f(d)*g(d)^(n/d))*x^n/n),  <br />
 * we see that b(n) is given explicitly by b(n) = (1/n) * Sum_{k=1..n} c(k)*b(n-k) <br />
 * where c(n) = Sum_{d|n} d*f(d)*g(d)^(n/d). <br />
 * The algorithm here uses a monotone increasing function h(k) (default: h(k) := k) such that<br />
 * g(k) := 0 for k != h(k). <br />
 * Examples: <br />
 * 1. If we set g(k) := 1, we get the usual Euler transform. <br />
 * 2. If we set f(k) := - f1(k) and g(k) := -1, we get the weighout transform (cf. A026007). <br />
 * 3. If we set f(k) := - n (A001478) and g(k) := k (A000027), we get A266964. <br />
 * 4. With the default f(k) := g(k) := A000012 (all 1's), we get A000041 (number of partitions of n). <br />
 * @author Georg Fischer
 */
public class RationalProductTransform extends AbstractSequence implements RationalSequence {

  private static int sDebug = 0;
  private static final int ESTLEN = 16384; // estimated length of arrays
  private final ArrayList<Q> mFs = new ArrayList<>(ESTLEN); // first underlying sequence (Manyama's f(k))
  private final ArrayList<Q> mGs = new ArrayList<>(ESTLEN); // second underlying sequence (Manyama's g(k))
  private final ArrayList<Q> mBs = new ArrayList<>(ESTLEN); // resulting sequence (Manyama's a(n))
  private final ArrayList<Q> mCs = new ArrayList<>(ESTLEN); // auxiliary sequence (Manyama's b(n))
  private long mStopH; // next term of the sequence h(k)
  private int mIn; // index for initial terms
  private int mK; // current index k >= 1 for f() and g()
  private int mKh; // current index for h()
  private int mN; // index of resulting term
  private Z mFactorial; // = k!

//*  private int mGfType; // 0 = o.g.f., 1 = e.g.f.
  /* Caution, the following are bitmasks, c.f. usage at the end of <code>compute()</code>: */
  /** Bitmask indicating the numerators of an ordinary target generating function. */
  private static final int OGF = 0;
  /** Bitmask indicating the numerators of an exponential target or an exponential source generating function. */
  private static final int EGF = 1;
  /** Bitmask indicating the denominators of an ordinary target generating function. */
  private static final int DEN_OGF = 4;
  /** Bitmask indicating the denominators of an exponential target generating function. */
  private static final int DEN_EGF = 5;

  private Builder mBuilder; // encapsulates the parameters
  
      /** state of the finite automaton */
  private enum FunctionType
      { FT_NULL       // parameter is absent, take the default (usually 1)
      , FT_CONST_L    // a constant long
      , FT_LAMBDA_L   // a lambda expression k -> Long
      , FT_LAMBDA_Z   // a lambda expression k -> Z
      , FT_LAMBDA_Q   // a lambda expression k -> Q
      , FT_SEQUENCE_Z // next,  successive terms of a Sequence
      , FT_SEQUENCE_Q // nextQ, successive terms of a RationalSequence
      };

  /**
   * Builder inner class for flexible parameter setup.
   */
  public static class Builder {
    private int mOffset; // first index
    private FunctionType mFType; // type of function f()
    private FunctionType mGType; // type of function g()
    private FunctionType mHType; // type of function h() 
    private long mFVal;
    private long mGVal;
    private long mHVal;
    private Function<Integer, Z> mFLambdaZ;
    private Function<Integer, Z> mGLambdaZ;
    private Function<Integer, Q> mFLambdaQ;
    private Function<Integer, Q> mGLambdaQ;
    private Function<Integer, Long> mHLambdaL;
    private Sequence mFSequenceZ; // sequence for the exponent of the parenthesis: 1/(1-x^k)^f(k)
    private Sequence mGSequenceZ; // sequence for the factor of x^k: 1/(1-g(k)*x^k)^f(k)
    private Sequence mHSequenceZ; // monontone increasing (!) sequence for the exponent of x: 1/(1-g(k)*x^h(k))^f(k)
    private RationalSequence mFSequenceQ; // RationalSequence for the exponent of the parenthesis: 1/(1-x^k)^f(k)
    private RationalSequence mGSequenceQ; // RationalSequence for the factor of x^k: 1/(1-g(k)*x^k)^f(k)
    private int mGfType; // type of the resulting generating function
    private Q[] mPreTerms; // initial terms to be prepended

    /**
     * Empty constructor, sets the defaults for all optional parameters.
     */
    public Builder() {
      mHLambdaL = k -> (long) k;     // default: h=k in prod(1/(1 - x^h))
      mFType = FunctionType.FT_NULL; // default: f=1 in prod(1/(1 - x^k)^f)
      mGType = FunctionType.FT_NULL; // default: g=1 in prod(1/(1 - g*x^k))
      mHType = FunctionType.FT_LAMBDA_L;
      mGfType = OGF;
      mPreTerms = QUtils.toQ("1");
    }

    public Builder f(final long val) {
      mFVal = val;
      mFType = FunctionType.FT_CONST_L;
      return this;
    }

    public Builder f(Function<Integer, Z> lambda) {
      mFLambdaZ = lambda;
      mFType = FunctionType.FT_LAMBDA_Z;
      return this;
    }

    public Builder f(final Sequence seq) {
      mFSequenceZ = seq;
      mFType = FunctionType.FT_SEQUENCE_Z;
      return this;
    }

    public Builder fq(final RationalSequence seq) {
      mFSequenceQ = seq;
      mFType = FunctionType.FT_SEQUENCE_Q;
      return this;
    }

    public Builder fq(Function<Integer, Q> lambda) {
      mFLambdaQ = lambda;
      mFType = FunctionType.FT_LAMBDA_Q;
      return this;
    }

    public Builder g(final long val) {
      mGVal = val;
      mGType = FunctionType.FT_CONST_L;
      return this;
    }

    public Builder g(Function<Integer, Z> lambda) {
      mGLambdaZ = lambda;
      mGType = FunctionType.FT_LAMBDA_Z;
      return this;
    }

    public Builder gq(Function<Integer, Q> lambda) {
      mGLambdaQ = lambda;
      mGType = FunctionType.FT_LAMBDA_Q;
      return this;
    }

    public Builder g(final Sequence seq) {
      mGSequenceZ = seq;
      mFType = FunctionType.FT_SEQUENCE_Z;
      return this;
    }

    public Builder gq(final RationalSequence seq) {
      mGSequenceQ = seq;
      mFType = FunctionType.FT_SEQUENCE_Q;
      return this;
    }

    public Builder h(Function<Integer, Long> lambda) {
      mHLambdaL = lambda;
      mHType = FunctionType.FT_LAMBDA_L;
      return this;
    }

    public Builder prepend(final String preTerms) {
      mPreTerms = QUtils.toQ(preTerms);
      return this;
    }

    public Builder egf() {
      mGfType |= EGF;
      return this;
    }

    public Builder den() {
      mGfType |= DEN_OGF;
      return this;
    }

    /**
     * Build the instance (not used).
     */
    public RationalProductTransform build() {
      return new RationalProductTransform(mOffset, this);
    } 
  } // Builder inner class

  /**
   * Constructor with Builder
   * @param offset first index
   * @param builder {@link #Builder} inner class for flexible parameter setup
   */
  public RationalProductTransform(final int offset, final Builder builder) { 
    super(offset); 
    mBuilder = builder;
    mN = offset - 1;
    mIn = 0; // for prepending
    mK = 0;
    for (int k = 0; k < 1; ++k) { // kStart; ++k) {
      mFs.add(Q.ZERO); // [0] not used
      mGs.add(Q.ZERO); // [0] not used
      mBs.add(Q.ZERO); // [0] is not returned
      mCs.add(Q.ZERO); // [0] starts the sum
    } // while < kStart
    final int kStart = 1;
    mKh = (kStart <= 1) ? kStart : 1;
    mStopH = mBuilder.mHLambdaL.apply(mKh);
    mFactorial = Z.ONE;
  }

  /**
   * Return a rational term.
   * @return the next term of the transformed sequence.
   */
  @Override
  public Q nextQ() {
    ++mN;
    if (mIn < mBuilder.mPreTerms.length) { // during prepend phase
      return mBuilder.mPreTerms[mIn++];
    }
    ++mK; // starts with 1
    //----------------
    Q nextF = Q.ONE;
    switch (mBuilder.mFType) {
      case FT_CONST_L:
        nextF =  Q.valueOf(mBuilder.mFVal); 
        break;
      case FT_LAMBDA_Z:
        nextF = Q.valueOf(mBuilder.mFLambdaZ.apply(mK));
        break;
      case FT_LAMBDA_Q:
        nextF = mBuilder.mFLambdaQ.apply(mK);
        break;
      case FT_SEQUENCE_Z:
        nextF = Q.valueOf(mBuilder.mFSequenceZ.next());
        break;
      case FT_SEQUENCE_Q:
        nextF = mBuilder.mFSequenceQ.nextQ();
        break;
      case FT_NULL:
      default:
        nextF = Q.ONE;
        break;
    }
    mFs.add(nextF);
    //----------------
    Q nextG = Q.ONE;
    switch (mBuilder.mGType) {
      case FT_CONST_L:
        nextG = Q.valueOf(mBuilder.mGVal);
        break;
      case FT_LAMBDA_Z:
        nextG = Q.valueOf(mBuilder.mGLambdaZ.apply(mK));
        break;
      case FT_LAMBDA_Q:
        nextG = mBuilder.mGLambdaQ.apply(mK);
        break;
      case FT_SEQUENCE_Z:
        nextG = Q.valueOf(mBuilder.mGSequenceZ.next());
        break;
      case FT_SEQUENCE_Q:
        nextG = mBuilder.mGSequenceQ.nextQ();
        break;
      case FT_NULL:
      default:
        nextG = Q.ONE;
        break;
    }
    if (mK < mStopH) {
      nextG = Q.ZERO; // invalidate this g(k)
    } else { // mK = mNextH : this g(k) is valid
      ++mKh;
      mStopH = mBuilder.mHLambdaL.apply(mK); // next stop value
    }
    mGs.add(nextG);
    //----------------

    Q cSum = Q.ZERO; // start sum
    final int kd2 = mK >> 1;
    for (int d = 1; d <= mK; ++d) { // compute c[k] = sum ...
      if (d == 1 || d == mK || (d <= kd2 && (mK % d == 0))) { // "did(mK,d)", "does it divide"
        // if (mK % d == 0) { // "did(mK,d)"
        final int idivd = mK / d;
        final Q fTerm = mFs.get(d);
        if (!fTerm.isZero()) { // ends in zero for all finite f(k)
          Q cTerm = fTerm.multiply(d);
          final Q gTerm = mGs.get(d);
          if (!gTerm.isZero()) {
            //---- start of the generalization
            if (!gTerm.equals(Q.ONE)) { // != 1
              if (gTerm.equals(Q.NEG_ONE)) {
                if ((idivd & 1) != 0) {
                  cTerm = cTerm.negate(); // *(-1)^odd
                } // (-1)^even: ignore
              } else { // != -1
                cTerm = cTerm.multiply(gTerm.pow(idivd));
              }
            } // else cTerm * 1^(...): ignore
            //---- end of generalization
            cSum = cSum.add(cTerm);
          } // else g(k) = 0: ignore
        } // else f(k) = 0: ignore
      } // else not "did(mK,d)"
    } // for d
    // mCs.set(mK, csum);
    mCs.add(cSum); // = c[k]

    Q bSum = mCs.get(mK);
    for (int d = 1; d < mK; ++d) {
      bSum = bSum.add(mCs.get(d).multiply(mBs.get(mK - d)));
    } // for d
    if (mK > 0) {
      bSum = bSum.divide(mK);
    }
//*    if (!mFRoot.isZero()) {
//*      final Z[] quotRem = bSum.divideAndRemainder(mFRoot);
//*      if (!quotRem[1].isZero()) {
//*        System.err.println("assertion in RationalProductTransform: remainder != 0 for k=" + mK);
//*      }
//*      bSum = quotRem[0];
//*    }
/*
    if (sDebug > 0) {
      System.err.println("mK=" + mK + "\tmKh=" + mKh 
          + "\tmStopH=" + mStopH + "\tnextF=" + nextF.toString() + "\tnextG=" + nextG.toString()
          + "\tc[k]=" + cSum.toString() + "\tb[k]=" + bSum.toString()
          );
    }
*/
    mBs.add(bSum);
    if ((mBuilder.mGfType & EGF) != 0) {
      if (mN > 0) {
        mFactorial = mFactorial.multiply(mN);
      }
      bSum = bSum.multiply(mFactorial);
      if (sDebug >= 1) {
        System.out.println("# mFactorial=" + mFactorial + ", mN=" + mN);
      }
    }
    return bSum;
  } // nextQ

  @Override
  public Z next() {
    final Q result = nextQ();
    return ((mBuilder.mGfType & DEN_OGF) == 0) ? result.num() : result.den();
  } // next

}
