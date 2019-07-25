package irvine.oeis;

import irvine.oeis.Sequence;
import irvine.math.z.Z;
import java.util.HashMap;

/**
 *  Generate OEIS Sequence A131393 and its companions
 *  as defined by Clark Kimberling
 */
public class NegativePositiveSequence implements Sequence {
  protected int mRule;
  protected int mSub;
  protected int mVariant;
  protected int mK;
  protected int mAk;
  protected int mDk;
  protected int mAk_1;
  protected int mDk_1;
  protected int mA1;
  protected int mD1;
  protected HashMap<Integer, Integer> mASet;
  protected HashMap<Integer, Integer> mDSet;

  /**
   * No-args constructor
   */
  public NegativePositiveSequence() {
    this(1, 1, "ak", 1, 0);
  } // no-args constructor

  /**
   * Constructor with parameters.
   * @param rule major rule number according to Clark Kimberling
   * @param sub minor rule number
   * @param op operation: ak or dk
   * @param a1 start value of ak
   * @param d1 start value pf dk
   */
  public NegativePositiveSequence(int rule, int sub, String op, int a1, int d1) {
    mRule    = rule;
    mSub     = sub;
    mA1      = a1;
    mD1      = d1;
    mASet    = new HashMap<Integer, Integer>(2048);
    mDSet    = new HashMap<Integer, Integer>(2048);
    if (false) {
    } else if (op.equals("ak")) {
      mVariant = 1;
    } else if (op.equals("dk")) {
      mVariant = 2;
    } else {
      System.err.println("variant \"" + op + "\" not implemented");
      mVariant = 0;
    }       
    mK    = 1;
    mAk   = mA1;
    mAk_1 = mAk;
    mDk   = mD1;
    mDk_1 = mDk;
    mASet.put(mAk, mK);
    mDSet.put(mDk, mK); // dk is h
  } // no-args constructor

  /**
   * Compute the next term of the sequence
   */
  public Z next() {
    Z result = Z.ZERO;
    switch (mVariant) {
      case 1: // ak
        result = Z.valueOf(mAk);
        break;
      case 2: // dk
        result = Z.valueOf(mDk);
        break;
      default:
        // result = 0;
    } // switch mVariant
    
    mK ++;
    { // implemented variants are ak, dk only
      boolean busy = true;
      if (false) {
      } else if (mRule == 1 || mRule == 2) { // for A131388, A257705 et al.
        mDk = -1; // start downwards
        if (mRule == 2 && mDk_1 < 0) { // for A131393 et al.
          mDk = mDk_1 - 1;
        }
        while (busy && mDk > mSub - mAk_1) { // downwards
          mAk = mAk_1 + mDk;
          if (mASet.get(mAk) == null && mDSet.get(mDk) == null && mAk > 0) {
            busy = false;
            mASet.put(mAk, mK);
            mDSet.put(mDk, mK);
          } else {
            mDk --;
          }
        } // while downwards
        if (busy) {
          mDk = +1; // start upwards
        }
        while (busy                   ) { // upwards
          mAk = mAk_1 + mDk;
          if (mASet.get(mAk) == null && mDSet.get(mDk) == null) {
            busy = false;
            mASet.put(mAk, mK);
            mDSet.put(mDk, mK);
          } else {
            mDk ++;
          }
        } // while upwards
      } else if (mRule == 3) { // for A257905, 908
        mDk = mSub - mAk_1 + 1; // start upwards in negative
        while (busy && mDk < 0) {
          mAk = mAk_1 + mDk;
          if (mASet.get(mAk) == null && mDSet.get(mDk) == null && mAk > 0) {
            busy = false;
            mASet.put(mAk, mK);
            mDSet.put(mDk, mK);
          } else {
            mDk ++;
          }
        } // while negative
        if (busy) {
          mDk = +1; // start upwards
        }
        while (busy                     ) { // upwards
          mAk = mAk_1 + mDk;
          if (mASet.get(mAk_1 - mDk) == null && mDSet.get(mDk) == null) {
            busy = false;
            mASet.put(mAk, mK);
            mDSet.put(mDk, mK);
          } else {
            mDk ++;
          }
        } // while upwards
      } else if (mRule == 4) { // "Algorithm" for A257883 et al.
        mDk = mSub - mAk + 1;
        while (busy                      ) { // upwards
          mAk = mAk_1 + mDk;
          if (mASet.get(mAk) == null && mDSet.get(mDk) == null && mAk > 0) {
            busy = false;
            mASet.put(mAk, mK);
            mDSet.put(mDk, mK);
          } else {
            mDk ++;
          }
        } // while upwards
      }
      mAk_1 = mAk;
      mDk_1 = mDk;
      mK ++; // iterate
    }
    return result;
  } // next

} // class NegativePositiveSequence

