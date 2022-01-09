package irvine.oeis;

import java.util.ArrayList;
import java.util.regex.Pattern;

import irvine.math.z.Z;

/**
 * Numbers that contain only a subset of decimal digits in the number 
 * and in its square. For some subsets of the 10 digits there are 
 * only rare or no solutions. 
 * The algorithm processes a queue of blocks of possible numbers of length <em>width</em>.
 * Any digit from the subset is prefixed to each member of a block,
 * and then the squares are checked. The numbers are requeued 
 * if and only if the square mod 10^width has possible digits only.
 * If the subset contains '0', a number starting with '0' 
 * may not be output (again).
 * @author Georg Fischer
 */
public class SquareDigitsSequence implements Sequence {

  protected int mN; // index of current term to be returned
  //protected int mOffset; // OEIS offset1 as of generation time
  protected String mSubset; // the decimal digits of the subset in ascending order
  //protected int mBase; // base of the numbers: 2-99
  protected int mMode; // type of the test: 2 = digits in square
  protected Pattern mAllowPattern; // pattern matching the subset of not-allowed decimal digits 
  protected int mDigLen; // number of digits in subset
  protected String[] mDigits; // the allowed digits as Strings
  
  private ArrayList<String> mQueue; // blocks of possible number endings, only with allowed digits
  private int mOldLen; // starting index of current block
  private int mNewLen; // ending index of current block + 1
  private int mIndDig; // index of current digit
  private int mIndQ; // index of number in mQueue
  private int mWidth; // width of numbers in current block
/**/ protected static int sDebug = 1;

  /**
   * Construct an instance which selects all numbers
   * that contain only a subset of decimal digits in the number 
   * and in its square.
   * @param offset first valid term has this index
   * @param base base of the numbers: 2-99
   * @param mode type of the test to be applied to the digits: 2 = digits in square
   * @param subset String of decimal digits in ascending order, representing the desire subset
   */
  protected SquareDigitsSequence(final int offset, final int base, final int mode, final String subset) {
    //mOffset = offset;
    mN = 0;
    //mBase = base;
    mMode = mode;
    mSubset = subset.replaceAll("\\D", "");
    mAllowPattern = Pattern.compile("[" + subset + "]*");
    if ((mode & 2) != 0) { // 2, 3: the number and its square must contain the subset only
      mDigLen = mSubset.length();
      mDigits = new String[mDigLen];
      for (int isub = 0; isub < mDigLen; ++isub) {
        mDigits[isub] = mSubset.substring(isub, isub + 1);
      } // for isub
    } else if ((mode & 4) != 0) { // 4, 5: the number can contain other digits
      mDigLen = 9;
      mDigits = new String[mDigLen];
      for (int isub = 0; isub < mDigLen; ++isub) {
        mDigits[isub] = String.valueOf(isub + 1);
      } // for isub
    }
    mIndDig = 0;
    mWidth = 0;
    mQueue = new ArrayList<>(1024);
    mQueue.add("");
    mOldLen = 0;
    mNewLen = 0;
    mIndQ = 0;
  }

  /**
   * Get the next term of the sequence.
   * @return the next term
   */
  @Override
  public Z next() { 
    Z result = null;
    boolean found = false;
    while (!found) {
      if (mIndDig >= mDigLen) { // increase width - start a new Queue
        ++mWidth;
        // maybe mQueue.removeRange(0, mOldLen); - but with resetting the indexes old/new
        mOldLen = mNewLen;
        mNewLen = mQueue.size();
        mQueue.ensureCapacity(mOldLen + mOldLen * mDigLen);
        mIndDig = 0;
        mIndQ = mOldLen;
      } 
      if (mIndQ < mNewLen) { // prefix current digit to all in Queue
        final String number = mDigits[mIndDig] + mQueue.get(mIndQ); // contains valid digits only, by construction
        result = new Z(number);
        final Z res2 = result.square();
        if ((mMode & 1) != 0) {
          result = res2; // return the k^2 instead of k for odd modes
        }
        final String num2 = res2.toString();
/**/    if (sDebug >= 1) {
/**/       System.out.println("candidate " + number + ", ^2=" + num2 + ", digit= " + mDigits[mIndDig]);
/**/    }
        if (mAllowPattern.matcher(num2).matches()) { // contains valid digits only
          if (mDigits[mIndDig].charAt(0) != '0' || mWidth <= 1) {
            found = true;
/**/        if (sDebug >= 1) {
/**/          System.out.println("push-num " + mQueue.size() + ": " + number.toString() + " " + num2);
/**/        }
          }
          mQueue.add(number);
        } else { // test whether square mod width matches
          final int len2 = num2.length();
          if (mAllowPattern.matcher(num2.substring(len2 - number.length(), len2)).matches()) { // and queue then
/**/        if (sDebug >= 1) {
/**/          System.out.println("push-sqp " + mQueue.size() + ": " + number.toString() + " " + num2);
/**/        }
            mQueue.add(number);
          }
        }
        ++mIndQ;
      } else { // Queue is exhausted for current digit, take next digit 
        ++mIndDig;
        mIndQ = mOldLen;
      } // next digit
    } // while not found 
    ++mN;
    return result;
  } // next

  //=====================================
  /*  Test method 
   *  @param args command line arguments: [noterms [digits]]
   *  Show various elements related to the runs of digits for some base in n.
   */
/**/  public static void main(String[] args) {
/**/    String  subset = "23467"; // A137071
/**/    int     noTerms   = 8;
/**/    int     mode = 2;
/**/    int iarg = 0;
/**/    while (iarg < args.length) { // consume all arguments
/**/      final String opt = args[iarg ++];
/**/      try {
/**/        if (false) {
/**/        } else if (opt.equals    ("-d")     ) {
/**/          SquareDigitsSequence.sDebug = Integer.parseInt(args[iarg++]);
/**/        } else if (opt.equals    ("-m")     ) {
/**/          mode    = Integer.parseInt(args[iarg++]);
/**/        } else if (opt.equals    ("-n")     ) {
/**/          noTerms = Integer.parseInt(args[iarg++]);
/**/        } else if (opt.equals    ("-s")     ) {
/**/          subset  = args[iarg++];
/**/        } else {
/**/          System.err.println("??? invalid option: \"" + opt + "\"");
/**/        }
/**/      } catch (Exception exc) { // take default
/**/      }
/**/    } // while args
/**/    SquareDigitsSequence seq = new SquareDigitsSequence(1, 10, mode, subset);
/**/    int index = 1;
/**/    while (index < noTerms) {
/**/      System.out.println(index + " " + seq.next().toString());
/**/      ++index;
/**/    } // while index
/**/  } // main
} // SquareDigitsSequence
