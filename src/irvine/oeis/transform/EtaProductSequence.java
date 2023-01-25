package irvine.oeis.transform;

import java.util.Arrays;

import irvine.math.LongUtils;
import irvine.math.q.Q;
import irvine.math.z.Z;
import irvine.math.z.ZUtils;
import irvine.oeis.AbstractSequence;
import irvine.oeis.recur.PeriodicSequence;

/**
 * This class implements a sequence that is derived from the coefficients
 * of a product of eta functions.
 * @author Georg Fischer
 */
public class EtaProductSequence extends AbstractSequence {

  private static int sDebug = 0;
  private EulerTransform mET; // the EulerTransform used to compute the sequence
  private Z[] mPreTerms; // initial terms for a(n)
  private boolean mIsConfigured; // whether the period for the EulerTransform has already been computed
  private final String mEPSig; // a list of pairs (k=exponent of q, m=exponent of eta(q^k)) as a String of the form "[k0,m0;k1,m1;...]".
  private long[] mPeriod; // expanded list of numbers used for the Euler transform
  private int[] mQpowers; // powers of q
  private int[] mEpowers; // powers of the eta functions
  private final String mPQF; // power of leading q factor
  private int mPQFNum; // numerator of mPQF
  private int mPQFDen; // denominator of mPQF
  private int mN; // for skipping if mPQF != "-1/1"

  /**
   * Construct an eta product sequence from String parameters.
   * @param offset first valid term has this index
   * @param epsig list of pairs (q, e) as a String of the form "[q0,e0;q1,e1;q2,e2]".
   * @param preTerms list of initial terms
   * @param pqf power of leading q factor
   */
  public EtaProductSequence(final int offset, final String epsig, final String pqf, final long... preTerms) {
    super(offset);
    mIsConfigured = false;
    mEPSig = epsig;
    mPreTerms = ZUtils.toZ(preTerms);
    mPQF = pqf;
    mN = -1;
  }

  /**
   * Construct an eta product sequence from String parameters.
   * @param offset first valid term has this index
   * @param epsig list of pairs (q, e) as a String of the form "[q0,e0;q1,e1;q2,e2]".
   * @param preTerms list of initial terms
   */
  public EtaProductSequence(final int offset, final String epsig, final long... preTerms) {
    this(offset, epsig, "-1/1", preTerms);
  }

  /**
   * Construct an eta product sequence from String parameters.
   * @param offset first valid term has this index
   * @param epsig list of pairs (q, e) as a String of the form "[q0,e0;q1,e1;q2,e2]".
   * @param pqf power of leading q factor
   */
  public EtaProductSequence(final int offset, final String epsig, final String pqf) {
    this(offset, epsig, pqf, new long[] { 1 });
  }

  /**
   * Construct an eta product sequence from String parameters.
   * @param offset first valid term has this index
   * @param epsig a list of pairs (q, e) as a String of the form "[q0,e0;q1,e1;q2,e2]".
   */
  public EtaProductSequence(final int offset, final String epsig) {
    this(offset, epsig, "-1/1", new long[] { 1 });
  }

  /**
   * Construct an eta product sequence from String parameters.
   * @param offset first valid term has this index
   * @param epsig a list of pairs (q, e) as a String of the form "[q0,e0;q1,e1;q2,e2]".
   * @param preTerms list of initial terms as String
   * @param pqf pqf of leading q factor
   */
  public EtaProductSequence(final int offset, final String epsig, final String pqf, final String preTerms) {
    this(offset, epsig, pqf, LongUtils.toLong(preTerms));
  }

  /**
   * Configure the class by computing the period for the Euler transform.
   */
  protected void configure() {
    mPQFNum = -1; // defaults
    mPQFDen = 1;
    try {
      mPQFNum = Integer.parseInt(mPQF.substring(0, mPQF.indexOf('/')));
      mPQFDen = Integer.parseInt(mPQF.substring(mPQF.indexOf('/') + 1));
    } catch (final NumberFormatException exc) { // take default 1
    }
    final String[] pairs = mEPSig.replaceAll("[\\[\\]]", "").split("[\\;\\/\\|]"); // pair separator may be ";", "/" or "|"
    final int noPairs = pairs.length;
    mQpowers = new int[noPairs];
    mEpowers = new int[noPairs];
    long lcm = 1;
    for (int ip = 0; ip < noPairs; ++ip) {
      mQpowers[ip] = 1;
      mEpowers[ip] = 1;
      final String[] pair = pairs[ip].split("\\,");
      try {
        mQpowers[ip] = Integer.parseInt(pair[0]);
        mEpowers[ip] = Integer.parseInt(pair[1]);
      } catch (final NumberFormatException exc) { // take default 1
      }
      lcm = LongUtils.lcm(lcm, mQpowers[ip]);
    }
    lcm = lcm > 0x80000 ? 0x80000 : lcm; // limit it to 19 bits = 524288
    mPeriod = new long[(int) lcm];
    Arrays.fill(mPeriod, 0);
    for (int ip = 0; ip < noPairs; ++ip) {
      for (int j = mQpowers[ip]; j <= lcm; j += mQpowers[ip]) {
        mPeriod[j - 1] += -mEpowers[ip]; // eta = period[-1]
      }
    }
    Z pqf = Z.ZERO;
    for (int ip = 0; ip < noPairs; ++ip) {
      pqf = pqf.add(Z.valueOf(mQpowers[ip]).multiply(mEpowers[ip]));
    }
    final int shift = pqf.divide(24).intValue() - (getOffset() - (-1)) + 1;
    final int numer = pqf.mod(Z.valueOf(24)).intValue();
    mPreTerms = new Z[shift + 1];
    int ipre = mPreTerms.length;
    mPreTerms[--ipre] = Z.ONE;
    while (ipre >= 1) {
      mPreTerms[--ipre] = Z.ZERO;
    }
    mET = new EulerTransform(new PeriodicSequence(mPeriod), mPreTerms);
    mIsConfigured = true;
  }

  /**
   * Set the debugging level.
   * @param level code for the debugging level: 0 = none, 1 = some, 2 = more.
   */
  public static void setDebug(final int level) {
    sDebug = level;
  }

  /**
   * Get the eta product signature.
   * @return a String of the form "[k0,m0;k1,m1;...]"
   */
  public String getEPSig() {
    return mEPSig;
  }

  /**
   * Get the period.
   * @return expanded list of numbers used for the Euler transform.
   */
  public long[] getPeriod() {
    if (!mIsConfigured) {
      configure();
    }
    return mPeriod;
  }

  /**
   * Get a String representation of the initial terms.
   * @return a list of terms of the form "[0,1,1,2,1]".
   */
  public String getPreTerms() {
    if (!mIsConfigured) {
      configure();
    }
    final StringBuilder result = new StringBuilder(256);
    for (int j = 0; j < mPreTerms.length; ++j) {
      if (j > 0) {
        result.append(',');
      }
      result.append(mPreTerms[j].toString());
    }
    return result.toString();
  }

  /**
   * Get the leading power of q factor
   * @return a string of the form "n/d"
   */
  public String getPQF() {
    return mPQF;
  }

  /**
   * Get the next term of the sequence.
   */
  @Override
  public Z next() {
    if (!mIsConfigured) {
      configure();
    }
    while (true) {
      ++mN;
      final Z result = mET.next();
      if (mN % mPQFDen == 0) {
        return result;
      }
    }
  }

  /**
   * Main method: compute the period and show 16 terms
   * @param args command line arguments:
   * <ul>
   * <li>-p period list of terms (default: "[1,5;5,-5]")</li>
   * <li>-i list of initial terms, default "1"</li>
   * <li>-n number of terms to be generated (default: 32)</li>
   * <li>-q power of q factor as String fraction (default: "-1/1")</li>
   * </ul>
   */
  public static void main(final String[] args) {
    sDebug = 0;
    String epsig = "[1,5;5,-5]"; // A285932
    String initString = "1";
    String pqf = "-1/1";
    int noTerms = 32;
    int iarg = 0;
    while (iarg < args.length) { // consume all arguments
      final String opt = args[iarg++];
      try {
        if (opt.equals("-d")) {
          sDebug = 1;
          sDebug = Integer.parseInt(args[iarg++]);
        } else if (opt.equals("-i")) {
          initString = args[iarg++].replaceAll("\\s", ""); // remove whitespace
        } else if (opt.equals("-n")) {
          noTerms = Integer.parseInt(args[iarg++]);
        } else if (opt.equals("-p")) {
          epsig = args[iarg++].replaceAll("\\s", ""); // remove whitespace
        } else if (opt.equals("-q")) {
          pqf = args[iarg++].replaceAll("\\s", ""); // remove whitespace
        } else {
          System.err.println("??? invalid option: \"" + opt + "\"");
        }
      } catch (final NumberFormatException exc) { // take default
      }
    } // while args
    final EtaProductSequence eps = new EtaProductSequence(0, epsig, pqf, initString);
    final String preTerms = eps.getPreTerms();
    System.out.println("PreTerms=" + preTerms);
    final long[] period = eps.getPeriod();
    final int plen = period.length > 0x100 ? 0x100 : period.length; // show the first 256 only
    System.out.print("period of length " + period.length + ":\n[");
    for (int i = 0; i < plen; ++i) {
      if (i > 0) {
        System.out.print(",");
      }
      System.out.print(period[i]);
    }
    if (plen < period.length) {
      System.out.print(" ...");
    }
    System.out.println("]");
    for (int iterm = 0; iterm < noTerms; ++iterm) {
      if (iterm > 0) {
        System.out.print(",");
      }
      System.out.print(eps.next());
    } // for iterm
    System.out.println();
  } // main
}
