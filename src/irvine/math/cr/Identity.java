package irvine.math.cr;

/**
 * Identity function
 * @author Hans.Boehm@hp.com
 * @author Sean A. Irvine
 */
class Identity extends UnaryCRFunction {

  @Override
  public CR execute(final CR x) {
    return x;
  }
}
