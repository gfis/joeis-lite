package irvine.oeis.producer;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.concurrent.TimeUnit;

import irvine.oeis.Sequence;
import irvine.util.io.IOUtils;
import irvine.util.string.StringUtils;

/**
 * The standard Producer for sequences backed by a LODA implementation.
 * @author Georg Fischer
 */
public class LodaProducer implements Producer {

  private static final String PROG_ROOT = System.getProperty("prog.root", "../../../loda-programs");
  public  static final boolean mVerbose = "true".equals(System.getProperty("oeis.verbose"));

  /**
   * Read a LODA program from the disk.
   * @param aNumber A123456 (7 characters).
   * @return String of assembly program lines concatenated by newline characters.
   */
  public static String getProgram(final String aNumber) {
    if (aNumber.length() != 7) {
      return null;
    }
    final File path = new File(new File(new File(PROG_ROOT, "asm"), aNumber.substring(1, 4)), aNumber.substring(1) + ".asm");
    if (!path.exists() || !path.isFile()) {
      if (mVerbose) {
        StringUtils.message("No implementation was found at " + path);
      }
      return null; // No LODA program for the sequence exists
    }
    final String lodaProgram;
    try {
      lodaProgram = IOUtils.readAll(path);
    } catch (final IOException e) {
      if (mVerbose) {
        StringUtils.message("Failed to read: " + path);
      }
      return null; // Failed to read the LODA program
    }
    return lodaProgram;
  }

  @Override
  public Sequence getSequence(final String aNumber) {
    return new LodaSequence(getProgram(aNumber));
  }
}
