package irvine.oeis;

import irvine.math.z.Z;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
/**
 * Properties of the runs of digits of a number,
 * This class is used for the runs of a single number, 
 * and for the property sequences for
 * the runs of digits in all numbers.
 * @author Georg Fischer
 */
public class RunsBaseSequence implements Sequence {

  protected int mN; // index of current term to be returned
  protected Z mK; // current number with some property
  protected int mOffset; // OEIS offset1 as of generation time

  /**
   * Construct an instance which selects all numbers
   * that have some property in the runs of digits to some base.
   * @param offset first valid term has this index
   */
  protected RunsBaseSequence(final int offset) {
    mOffset = offset;
    mN = offset - 1;
    mK = Z.valueOf(mN);
  }

  /**
   * Construct a sequence for runs of digits
   * of a single, specified number.
   * @param offset first valid term has this index
   * @param k investigate the runs of digits in this non-negative number
   */
  protected RunsBaseSequence(final int offset, final int k) {
    this(offset);
    mK = Z.valueOf(k);
  }

  /**
   * Construct a sequence of numbers containing some subset of digits only.
   * @param offset first valid term has this index
   * @param base base of the numbers: 2-99
   * @param mode type of the test to be applied to the digits: 2 = digits in square
   * @param subset pattern matching the subset of allowed decimal digits 
   */
  protected RunsBaseSequence(final int offset, final int base, final int mode, final String subset) {
    this(offset);
    mBase = base;
    mMode = mode;
    mSubset = subset;
    initializeSubset();
  }

  /**
   * Ensure that the current number has at least a specified number of digits.
   * @param width number of required digits
   * @param base represent the number in this base
   */
  protected Z ensureWidth(int width, int base) {
    int num = 1;
    int iwid = width - 1;
    while (iwid > 0) {
      num *= base;
      --iwid;
    } // while 
    return Z.valueOf(--num);
  } // ensureWidth

  /**
   * Get the number of runs from a number represented in some base.
   * @param number get the run count from this number
   * @param base represent in this base
   * @return number of subsequences with identical digits
   */
  protected int getRunCount(Z number, int base) {
    String digits;
    int dlen = 1; // assume 1 character per digit
    if (base <= 10) { // one character per digit
      digits = number.toString(base);
    } else { // two characters per digit
      dlen = 2;
      digits = number.toTwoDigits(base);
      if ((digits.length() & 1) == 1) { // odd
        digits = "0" + digits; // make sure that there are pairs
      }
    } // > 10
    int idig = digits.length() - dlen;

    String runElem = digits.substring(idig, idig + dlen);
    int count = 1; // there is always one element = 1 run
    idig -= dlen;
    while (idig >= 0) {
      if (! digits.substring(idig, idig + dlen).equals(runElem)) {
        ++count;
        runElem = digits.substring(idig, idig + dlen);
      }
      idig -= dlen;
    } // while
    return count;
  } // getRunCount

  /**
   * Determine whether the number of runs in a number represented 
   * in some base has a specific value.
   * @param number get the run count from this number
   * @param base represent in this base
   * @param value so many runs are required
   * @return true if the number of run has the value <em>count</em>
   */
  protected boolean hasRunCount(Z number, int base, int value) {
    String digits;
    int dlen = 1; // assume 1 character per digit
    if (base <= 10) { // one character per digit
      digits = number.toString(base);
    } else { // two characters per digit
      dlen = 2;
      digits = number.toTwoDigits(base);
      if ((digits.length() & 1) == 1) { // odd
        digits = "0" + digits; // make sure that there are pairs
      }
    } // > 10
    int idig = digits.length() - dlen;

    String runElem = digits.substring(idig, idig + dlen);
    int count = 1; // there is always one element = 1 run
    idig -= dlen;
    boolean busy = true;
    while (busy && idig >= 0) {
      if (! digits.substring(idig, idig + dlen).equals(runElem)) {
        ++count;
        busy = count <= value; // false if >
        runElem = digits.substring(idig, idig + dlen);
      }
      idig -= dlen;
    } // while
    return busy && count == value;
  } // hasRunCount

  /**
   * Get the number of digits in the base representation of number.
   * @param number number to be investigated
   * @param base represent in this base
   * @param digit count this digit (two characters for base > 10)
   * @return the count of digit in number
   */
  protected int getDigitCount(Z number, int base, int digit) {
    String digits;
    String search;
    int dlen = 1; // assume 1 character per digit
    if (base <= 10) { // one character per digit
      digits = number.toString(base);
      search = String.valueOf(digit);
    } else { // two characters per digit
      dlen = 2;
      digits = number.toTwoDigits(base);
      search = String.format("%02d", digit);
      if ((digits.length() & 1) == 1) { // odd
        digits = "0" + digits; // make sure that there are pairs
      }
    } // > 10
    int idig = digits.length() - dlen;

    int count = 0;
    while (idig >= 0) {
      if (digits.substring(idig, idig + dlen).equals(search)) {
        count++;
      }
      idig -= dlen;
    } // while
    return count;
  } // getDigitCount

  //=====================================
  /**
   * Get the next term of the sequence.
   * This is an example only.
   * The method is typically overwritten to get some other
   * element related to the runs of digits in this number.
   * @return the next term
   */
  @Override
  public Z next() {
    ++mN;
    return Z.valueOf(mN);
  } // next

  /**
   * Get some property of the next number.
   * This method is an example only.
   * It is typically overwritten in order to return some other property.
   * @return property of the next number
   */
  protected Z getNextProperty() {
    mK = mK.add(Z.ONE);
    return getProperty();
  } // getNextProperty

  /**
   * Get the next term of a sequence which fulfills some property.
   * @return the next number with the property
   */
  protected Z getNextWithProperty() {
    long loopCheck = 100000000L;
    while (loopCheck > 0) {
      mK = mK.add(Z.ONE);
      if (isOk()) {
        loopCheck = -1;
        break;
      }
      loopCheck --;
    } // while busy
    if (loopCheck == 0) {
      throw new IllegalArgumentException("more than 10^8 iterations in RunsBaseSequence.getNextWithProperty()");
    }
    return mK;
  } // getNextWithProperty

  /**
   * Get some property of the current number.
   * This method is an example only.
   * It is typically overwritten in order to return some other property.
   * @return a property of the current number <em>mK</em>.
   */
  protected Z getProperty() {
    return mK;
  } // getProperty

  /**
   * Determine whether the current number has the property which includes it in the sequence.
   * This method is an example only.
   * It is typically overwritten in order to test some other property.
   * @return true iff the current number <em>mK</em> has some property.
   */
  protected boolean isOk() {
    return true;
  } // isOk

  /**
   * Get the index of the current term of the sequence.
   * @return the index starting with the offset of the sequence
   */
  protected int getIndex() {
    return mN;
  } // getIndex

  //=====================================
  // Subset of digits in squares, A136nnn
  protected Pattern mSubsetPattern; // pattern matching the subset of allowed decimal digits 
  protected String mSubset; // the decimal digits of the subset in ascending order
  protected int subILast; // index of last character in mSubset
  protected char mSubFirst; // first character in mSubset
  protected char mSubLow; // first character in mSubset, or second if first is '0'
  protected int mBase; // base of the numbers: 2-99
  protected int mMode; // type of the test: 2 = digits in square
  protected boolean[] mHeadMod; // true iff square(first 2 digits) is possible
  protected boolean[] mTailMod; // true iff square(last  2 digits) is possible
  protected boolean[] mPossMod; // true iff 2 digits are possible
  protected StringBuffer mBuffer; // for subset increment
  private static final int MAX_MOD = 100;
  private static final int LEN_MOD = 2;

  /**
   * Initialize the buffer for advancing.
   */
  protected void initializeSubset() {
    subILast = mSubset.length() - 1;
    mSubFirst = mSubset.charAt(0);
    mSubLow = mSubFirst;
    if (mSubFirst == '0') {
      mSubLow = mSubset.charAt(1);
    }
    mSubsetPattern = Pattern.compile("[" + mSubset + "]+");
    switch (mMode) {
      case 2: // digits of square 
        mN = 0; // post increment because of advanceSubset(mK)
        mPossMod = new boolean[MAX_MOD];
        int imod;
        for (imod = 0; imod < MAX_MOD; imod ++) { // 0..99
          mPossMod[imod] = mSubsetPattern.matcher(String.format("%02d", imod)).matches();
        } // for imod
        mHeadMod = new boolean[MAX_MOD];
        mTailMod = new boolean[MAX_MOD];
        for (imod = 0; imod < MAX_MOD; imod ++) { // 0..99
          int imod2 = imod * imod;
          int tail2 = imod2 % 100;
          mTailMod[imod] = mPossMod[tail2]; 
          int head2 = (imod2 - tail2) / 100;
          int next2 = (imod2 + imod + imod + 1) / 100;
          boolean possible = mPossMod[head2];
          int jmod = head2 + 1; 
          while (! possible && jmod < next2) {
            possible = mPossMod[jmod];
            jmod++;
          } // while ! possible
          mTailMod[imod] = possible;
        } // for imod
        break;
    } // switch
    mBuffer = new StringBuffer(1024);
    mBuffer.append(String.valueOf(mN));
  } // initializeSubset  

  /**
   * Get up to LEN_MOD digits from a String.
   * @param source get the digits from this String
   * @param posLSD position of the least significant digit in source
   * @return an integer 0..99
   */ 
  protected int getMod(StringBuffer source, int posLSD) {
    int result = source.charAt(posLSD--) - '0';
    if (posLSD >= 0) {
      result += 10 * (source.charAt(posLSD) - '0');
    }
    return result;
  } // getMod
  
  /**
   * Advance the buffer to the next integer which contains the specified decimal digits only.
   */
  protected void advanceSubset() {
    boolean carry = true;
    int ipos = mBuffer.length() - 1;
    while (carry && ipos >= 0) { // advance the digit at ipos
      char digit = mBuffer.charAt(ipos);
      int dpos = mSubset.indexOf(digit);
      // assert dpos >= 0
      if (dpos < subILast) {
        mBuffer.setCharAt(ipos, mSubset.charAt(dpos + 1));
        carry = false;
      } else { // highest digit of subset
        mBuffer.setCharAt(ipos, mSubFirst);
      }
      --ipos;
    } // while ipos
    if (carry) { 
      mBuffer.insert(0, mSubLow);
    }
  } // advanceSubset  

  /**
   * Determine whether the square of some number uses a subset of digits only.
   * @param number test the square of this number
   * @param base represent in this base
   * @param subset list of allowed digits
   * @return true if the number of run has the value <em>count</em>
   */
  protected boolean hasSquareDigits(Z number) {
    boolean result = mSubsetPattern.matcher((number.multiply(number)).toString(mBase)).matches();
  /*
    System.err.println("hasSquareDigits, number=" + number.toString() 
        + ": " + (number.multiply(number)).toString(mBase) + ", result=" + String.valueOf(result));
  */
    return result;
  } // hasSquareDigits

  /**
   * Get the next term of a sequence which has a specified subseet of decimal digits only
   * @return the next number with the property
   */
  protected Z getNextWithDigits() {
    long loopCheck = 100000000L;
    String result = "";
    while (loopCheck > 0) {
      int kpos = mBuffer.length();
      int index =       (mBuffer.charAt(--kpos) - '0');
      if (kpos > 0) {
        index += 10   * (mBuffer.charAt(--kpos) - '0');
      }
      if (kpos > 0) {
        index += 100  * (mBuffer.charAt(--kpos) - '0');
      }
      if (kpos > 0) {
        index += 1000 * (mBuffer.charAt(--kpos) - '0');
      }
      if (mTailMod[index]) { // last few digits of square are possible
        result = mBuffer.toString();
        if (hasSquareDigits(new Z(result))) {
          loopCheck = -1;
        }
      }
      advanceSubset(); // post-increment because advanceSubset cannot handle negative
      loopCheck --;
    } // while busy
    if (loopCheck == 0) {
      throw new IllegalArgumentException("more than 10^8 iterations in RunsBaseSequence.getNextWithDigits()");
    }
    return new Z(result);
  } // getNextWithDigits  

  //=====================================
  /** Test method - for advanceSubset
   *  @param args command line arguments: [n [noterms]]
   *  Show various elements related to the runs of digits for some base in n.
   */
  public static void main(String[] args) {
    int n = 0;
    int noTerms = 16;
    int iarg = 0;
    if (iarg < args.length) {
      try {
        noTerms = Integer.parseInt(args[iarg ++]);
      } catch (Exception exc) {
      }
    }
    String subset = args[iarg ++];
    RunsBaseSequence seq = new RunsBaseSequence(1, 10, 2, subset);
    while (n < noTerms) {
      System.out.println(n + " " + seq.mBuffer.toString());
      seq.advanceSubset();
      n ++;
    } // while n
  } // main

} // RunsBaseSequence
