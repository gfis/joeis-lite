package irvine.oeis.producer;

import java.io.BufferedReader;
import java.io.InputStreamReader;

import irvine.oeis.PseudoSequence;
import irvine.oeis.Sequence;

/**
 * A special Producer that handles reading a sequence from a b-file directory.
 * @author Georg Fischer
 */
public class PseudoProducer implements Producer {

  @Override
  public Sequence getSequence(final String aNumber) {
    try {
      return new PseudoSequence(aNumber);
    } catch (Exception exc) {
      String env = System.getenv("BFPATH"); // Use environment variable BFPATH if that is set
      System.err.println("PseudoProducer: BFPATH=" + env + ", A-number=" + aNumber + " could not be read");
      return null;
    }
  }
}
