package irvine.oeis;

import java.util.ArrayList;
import java.util.function.Function;

import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.AbstractSequence;

/**
 * This class builds a sequence from a lambda expression, 
 * or from a simple annihilator of the form <code>p0 + p1*a(n) = 0</code>
 * with two polynomials in <code>n</code> 
 * (which can be understood as a lightweight version of <code>recur.HolonomicRecurrence</code>).
 * @author Georg Fischer
 */
public class LambdaSequence extends AbstractSequence {

  private Function<Integer, Z> mLambda; // lambda expression n -> f(n)
  protected int mNDist; // d >= 0 if a(n+d) is the highest and next element to be computed (0 <= d <= k).
  protected int mMaxDegree; // maximum degree of polynomials in n; = 0 for linear recurrences
  protected int mN; // index of the next sequence element to be computed
  protected Z[] mNdPowers; // powers of mNDist for exponents 0..mMaxDegree
  protected int mOrder; // order k-1 of the recurrence, number of previous sequence elements used to compute a(n)
  protected ArrayList<Z[]> mPolyList; // polynomials as coefficients of <code>n^i, i=0..m</code>

  /**
   * Construct the sequence.
   *
   * @param offset first index
   * @param lambda lambda expression for an index variable starting at <code>offset</code>.
   */
  public LambdaSequence(final int offset, final Function<Integer, Z> lambda) {
    super(offset);
    mLambda = lambda;
    mN = offset - 1;
    mPolyList = null;
  }

  /**
   * Construct the sequence with offset 0.
   *
   * @param offset first index
   * @param lambda lambda expression for an index variable starting at <code>offset</code>.
   */
  public LambdaSequence(final Function<Integer, Z> lambda) {
    this(0, lambda);
  }

  /**
   * Constructor with a String representation of to two polynomials in <code>n</code> with constant coefficients.
   *
   * The syntax and semantics of the string is the same as in <code>recur.HolonomicRecurrence</code>.
   * The string denotes an annihilator of the form <code>p0 + p1*a(n) = 0</code>.
   * @param offset    first valid term has this index
   * @param matrix    polynomials as coefficients of <code>n^i, i=0..m</code>,
   *                  as an array of String vectors, for example "[[0,1,2],[0],[17,0,18]]"
   *                  in the holonomic case, or a simple vector "[0,1,2]" in the linear case.
   *                  The brackets must be specified accordingly.
   */
  public LambdaSequence(final int offset, final String matrix) {
    super(offset);
    // this code is mostly copied from HolonomicRecurrence
    mNDist = 0; // compatibility
    int start = 0;
    while (matrix.charAt(start) == '[') {
      ++start;
    }
    int behind = matrix.length();
    while (matrix.charAt(behind - 1) == ']') {
      --behind;
    }
    mPolyList = new ArrayList<>();
    if (start <= 1) { // linear case, simple vector of the form "[0,1,2,...]"
      final String[] polys = matrix.substring(start, behind).split("\\s*,\\s*");
      for (int k = 0; k < polys.length; ++k) {
        mPolyList.add(new Z[] {new Z(polys[k])});
      } // for k
    } else { // holonomic case, vector list "[[0,1,2],[0],[17,0,18]]"
      final String[] polys = matrix.substring(start, behind).split("]\\s*,\\s*\\[");
      for (int k = 0; k < polys.length; ++k) {
        mPolyList.add(ZUtils.toZ(polys[k]));
      } // for k
    }
    mN = offset - 1;
    mMaxDegree = 1;
    int k = mPolyList.size() - 1;
    mOrder = k - 1;
    while (k >= 0) { // determine mMaxDegree
      final int klen = mPolyList.get(k).length;
      if (klen > mMaxDegree) {
        mMaxDegree = klen;
      }
      --k;
    }
    mNdPowers = new Z[mMaxDegree + 2]; // ensure that [0], [1] always exist
    mNdPowers[0] = Z.ONE;
  }

  /**
   * Constructor with String and without offset.
   *
   * @param matrix    polynomials as coefficients of <code>n^i, i=0..m</code>,
   *                  as an array of String vectors, for example "[[0,1,2],[0],[17,0,18]]"
   *                  in the holonomic case, or a simple vector "[0,1,2]" in the linear case.
   *                  The brackets must be specified accordingly.
   */
  public LambdaSequence(final String matrix) {
    this(0, matrix);
  }

  @Override
  public Z next() {
    Z result;
    ++mN;
    if (mPolyList == null) {
      result = mLambda.apply(mN);
    } else { 
      //  this code is copied from HolonomicRecurrence
      final int nd = mN - mNDist;
      mNdPowers[1] = Z.valueOf(nd);
      for (int m = 2; m < mMaxDegree; ++m) { // fill powers of mN
        mNdPowers[m] = mNdPowers[m - 1].multiply(nd);
      }
      int k = mPolyList.size() - 1;
      final Z[] pvals = new Z[k + 1];
      while (k >= 0) { // evaluate all polynomials
        Z pvalk = Z.ZERO; // one coefficient = value of a polynomial in n
        final Z[] poly = mPolyList.get(k);
        // handle the linear case separately
        Z coeffi = poly[0];
        if (!coeffi.isZero()) {
          pvalk = pvalk.add(coeffi);
        }
        for (int i = 1; i < poly.length; i++) { // possibly holonomic: evaluate polynomial in nd
          coeffi = poly[i];
          if (coeffi.isZero()) {
            // ignore
          } else if (coeffi.equals(Z.ONE)) {
            pvalk = pvalk.add(mNdPowers[i]);
          } else if (coeffi.equals(Z.NEG_ONE)) {
            pvalk = pvalk.subtract(mNdPowers[i]);
          } else { // abs(coeffi) > 1
            pvalk = pvalk.add(mNdPowers[i].multiply(coeffi));
          }
        } // for i - terms of one polynomial in nd
        pvals[k] = pvalk;
        --k;
      }
      // pvals[0..mOrder] now contain the coefficients of the recurrence equation
      final Z sum = pvals[0]; // k=0, the constant term (without a(k)) in the recurrence, mostly ZERO
      final Z pv1 = pvals[1];
      if (pv1.equals(Z.NEG_ONE)) { // if there is no overall denominator
        result = sum;
      } else if (!pv1.isZero()) {
        final Z[] quotRemd = sum.negate().divideAndRemainder(pv1);
        if (!quotRemd[1].isZero()) {
          throw new UnsupportedOperationException("division with rest");
        } else {
          result = quotRemd[0];
        }
      } else {
        throw new UnsupportedOperationException("division by zero");
      }
    }
    return result;
  }

  /**
   * Main test method: Evaluate a polynomial in <code>n</code>
   * @param args command line arguments:
   * <ul>
   * <li>-p comma-separated list of integer exponents of <code>n^e</code> for e=0..emax</li>
   * <li>-n number of terms (default 32)</li>
   * <li>-o offset, first index (default 0) </li>
   * </ul>
   */
  public static void main(final String[] args) {
    String poly = "[[0,1,1],[-2]]"; // triangular numbers k*(k + 1)/2
    int offset = 1;
    int noTerms = 32;
    int iarg = 0;
    while (iarg < args.length) { // consume all arguments
      final String opt = args[iarg++];
      try {
        if (opt.equals("-p")) {
          poly = args[iarg++];
        } else if (opt.equals("-n")) {
          noTerms = Integer.parseInt(args[iarg++]);
        } else if (opt.equals("-o")) {
          offset = Integer.parseInt(args[iarg++]);
        } else {
          System.err.println("??? invalid option: \"" + opt + "\"");
        }
      } catch (final Exception exc) { // take default
        System.err.println("wrong option: " + args[iarg - 1] + ", message: " + exc.getMessage());
      }
    } // while args

    final LambdaSequence seq = new LambdaSequence(offset, poly);
    for (int iterm = 0; iterm < noTerms; ++iterm) {
      if (iterm > 0) {
        System.out.print(",");
      }
      System.out.print(seq.next());
    } // for iterm
    System.out.println();
  } // main
}
