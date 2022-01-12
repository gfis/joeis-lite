package irvine.oeis;

import java.util.ArrayList;
import java.util.regex.Pattern;

import irvine.math.z.Z;

/**
 * Numbers that contain only a subset of digits in the square
 * and optionally in the number itself.
 * For some subsets of the 10 digits there are only rare or no solutions.
 *
 * The algorithm processes a block of possible numbers of length <em>width</em>.
 * Any digit from the subset is prefixed to each member of the block,
 * and then the squares (and the numbers) are checked.
 * The numbers in the block are requeued if and only if the square mod 10^width has allowable digits only.
 * There is an additional option that forbids trailing '0' digits in the number.
 * @author Georg Fischer
 */
public class SquareDigitsSequence implements Sequence {

  protected String mSubset; // the decimal digits of the subset in ascending order
  protected int mBase; // base of the numbers: 2-99
  protected Z mBaseZ; // base of the numbers: 2-99
  protected int mMask; // type of the test: 2 = digits in square
  protected Pattern mAllowPattern; // pattern matching the subset of not-allowed decimal digits
  protected int mDigLen; // number of digits in subset
  protected boolean[] mAllowedDigits; // the allowed digits as Strings
//**  protected static int sDebug;
  private Z[] mOldBlock;
  private int mOldIx;
  private int mNewIx;
  private int mOldLen;
  private int mNewLen;
  private Z[] mNewBlock;
  private Z mAdd1;
  private Z mAdd;
  private Z mMod;
  private Z mMod1;
  private Z mOldK;
  private int mDig;
  private int mFirstDig;
  private boolean mFirst0;
  protected int mN;
  private boolean mTestK;
  private boolean mNextK2;
  private boolean mNoZeroTail;

  /**
   * Construct an instance which selects all numbers
   * that contain only a subset of decimal digits in the number
   * and in its square.
   * @param offset first valid term has this index
   * @param base base of the numbers: 2-99
   * @param mask type of the test to be applied to the digits: 2 = digits in square
   * @param subset String of decimal digits in ascending order, representing the desire subset
   */
  protected SquareDigitsSequence(final int offset, final int base, final int mask, final String subset) {
//**    sDebug = 0;
    mBase = base;
    mBaseZ = Z.valueOf(mBase);
    mMask = mask;
    mTestK = (mask & 2) != 0;
    mNextK2 = (mask & 1) != 0;
    mNoZeroTail = (mask & 8) != 0;
    mSubset = subset.replaceAll("\\D","");
    mAllowPattern = Pattern.compile("[" + mSubset + "]*");
    mAllowedDigits = new boolean[mBase]; // initialized with false
    for (int isub = 0; isub < mSubset.length(); ++isub) { 
      mAllowedDigits[Character.digit(mSubset.charAt(isub), mBase)] = true;
    } // for isub
    mFirstDig = Character.digit(mSubset.charAt(0), mBase);
    mFirst0 = mFirstDig == 0;
    mOldBlock = new Z[] { Z.ZERO };
    mOldIx = 0;
    mOldLen = mOldBlock.length;
    mNewLen = mOldLen * mBase;
    mNewBlock = new Z[mNewLen];
    mNewIx = 0;
    mAdd1 = Z.ONE;
    mAdd = Z.ZERO;
    mMod = Z.valueOf(mBase);
    mOldK = Z.ZERO;
    mDig = 0;
    mN = 0;
  }

  /**
   * Test whether a number has allowable digits only.
   * @param k number to be tested
   * @return true or false
   */
  public boolean isAllowed(final Z k) {
    return mAllowPattern.matcher(k.toString()).matches();
  }

  /**
   * Get the next term of the sequence.
   * @return the next term
   */
  @Override
  public Z next() {
    if (mN == 0 && isAllowed(Z.ZERO) && !mNoZeroTail) {
      ++mN;
      return Z.ZERO;
    }
    while (true) {
      while (mDig < mBase) {
        if (!mTestK || mAllowedDigits[mDig]) {
          mMod1 = mMod.multiply(mFirstDig);
          while (mOldIx < mOldLen) {
            final Z k = mAdd.add(mOldBlock[mOldIx++]); // pop
            final Z k2 = k.multiply(k);
            final Z[] quot = k2.divideAndRemainder(mMod);
            final Z remainder = mFirstDig == 0 ? quot[1] : quot[1].add(mMod1);
            if (isAllowed(remainder)) {
              mNewBlock[mNewIx++] = k; // push
              if (  (quot[0].isZero() || isAllowed(quot[0]))
                 && (!mTestK          || isAllowed(k))
                 && (!mNoZeroTail     || k.mod(mBase) != 0)
                 && mOldK.compareTo(k) < 0
                 ) {
                mOldK = k;
                ++mN;
                return mNextK2 ? k2 : k;
              }
            }
          }
        }
        mOldIx = 0;
        mAdd = mAdd.add(mAdd1);
        ++mDig;
      }
      mDig = 0;
      mOldLen = mNewIx;
      mOldBlock = mNewBlock;
      mNewLen = mOldLen * mBase;
      mNewBlock = new Z[mNewLen];
      mNewIx = 0;
      mAdd1 = mAdd1.multiply(mBaseZ);
      mMod = mMod.multiply(mBaseZ);
      mAdd = Z.ZERO; 
    }
  } // next

  //=====================================
  /*  Test method
   *  @param args command line arguments: [noterms [digits]]
   *  Show various elements related to the runs of digits for some base in n.
   */
//**  public static void main(String[] args) {
//**    String  subset = "23467"; // A137071
//**    int     noTerms   = 8;
//**    int     mask = 2;
//**    int iarg = 0;
//**    while (iarg < args.length) { // consume all arguments
//**      final String opt = args[iarg ++];
//**      try {
//**        if (false) {
//**        } else if (opt.equals    ("-d")     ) {
//**          SquareDigitsSequence.sDebug = Integer.parseInt(args[iarg++]);
//**        } else if (opt.equals    ("-m")     ) {
//**          mask    = Integer.parseInt(args[iarg++]);
//**        } else if (opt.equals    ("-n")     ) {
//**          noTerms = Integer.parseInt(args[iarg++]);
//**        } else if (opt.equals    ("-s")     ) {
//**          subset  = args[iarg++];
//**        } else {
//**          System.err.println("??? invalid option: \"" + opt + "\"");
//**        }
//**      } catch (Exception exc) { // take default
//**      }
//**    } // while args
//**    SquareDigitsSequence seq = new SquareDigitsSequence(1, 10, mask, subset);
//**    int index = 1;
//**    while (index < noTerms) {
//**      System.out.println(index + " " + seq.next().toString());
//**      ++index;
//**    } // while index
//**  } // main
} // SquareDigitsSequence
