package seqbox;

import irvine.oeis.SequenceFactory;

import java.io.IOException;
import java.io.OutputStream;
import java.io.Serializable;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletOutputStream;

/** 
 * Seqbox main dialog page
 * @author Georg Fischer
<pre>
Usage: SequenceFactory [OPTION]... A-NUMBER

Required flags:
      A-NUMBER             Sequence to generate (or "-" to read standard input)

Optional flags:
  -a, --author=NAME        Specify author name for b-file output
  -B, --b-file             Output in b-file format
  -D, --data               Output in a format suitable for pasting into a DATA
                           line
      --data-length=NUMBER Maximum total length of output line in characters
                           (in conjunction with -D) (Default is 260)
      --header             Print a header
  -h, --help               Print help on command-line flag usage.
  -o, --offset=NUMBER      Offset to use (relevant for -B and -T with
                           --row-numbers) (Default is 1)
      --priority=STRING    Comma separated list of priority for programs (e.g.,
                           java,gp)
  -R, --right              Output data as an upper right triangle
      --row-numbers        Include row numbers in triangle (-T) output
  -r, --rows=NUMBER        Maximum number of rows to generate in a triangle (or
                           0 for unbounded) (Default is 0)
  -S, --square             Output data as a square array
  -n, --terms=NUMBER       Maximum number of terms to generate (or 0 for
                           unbounded) (Default is 0)
  -t, --timestamp          Add a timestamp to each line of output
  -T, --triangle           Output data as a triangle

Generate terms for an OEIS sequence.
</pre> 
 */
public class IndexPage implements Serializable {

    public final static long serialVersionUID = 19470629;

    /** 
     * Empty constructor
     */
    public IndexPage() {
    }

    /** 
     * Output the main dialog page for Seqbox.
     * @param request request with header fields
     * @param response response with writer
     * @param basePage reference to common methods and error messages
     * @param language 2-letter code en, de etc.
     * @param aseqno A-number
     * @param mode how to display the terms (data, b-file, triangle and so on)
     * @param opt options 
     * @param area output textarea for computed terms
     * @throws IOException for IO errors
     */
    public void dialog(final HttpServletRequest request, final HttpServletResponse response
            , final BasePage basePage
            , final String language
            , String aseqno
            , String mode
            , String opt
            , String area
            ) throws IOException {
        ServletOutputStream out = basePage.writeHeader(request, response, language);
        if (aseqno == null || aseqno.length() < 2) {
          aseqno = "A007318";
        }
        if (mode == null || mode.length() < 1) {
          mode = "D";
        }
        out.print("<title>" + basePage.getAppName() + " Main Page</title>\n");
        out.print("</head>\n<body>\n");

        String border = "0";
        int width  = 128;
        int height = 8;
        String[] optMode    = new String []
                { "D"    // 0
                , "B"    // 1
                , "R"    // 2
                , "S"    // 3
                , "T"    // 4
                } ;
        String[] enMode     = new String []
                { "D - data"
                , "B - b-file"
                , "R - upper right triangle"
                , "S - square array"
                , "T - triangle"
                } ;
        int index = 0;
        out.print("<!-- aseqno=\"" + aseqno + "\", mode=\""  + mode + "\", opt=\"" + opt + "\"\n");
        out.print("  area=\""  + area + "\"\n");
        out.print("-->\n");
        out.print("<h2>Seqbox - Toolkit for Seqfans</h2>\n");
        out.print("<form action=\"servlet\" method=\"get\">\n");
        out.print("  <input type = \"hidden\" name=\"view\" value=\"joeis\" />\n");
        out.print("  <table cellpadding=\"0\" border=\"" + border + "\">\n");
        out.print("    <tr valign=\"top\">\n");
        out.print("      <td><strong>A-Number:</strong><br />\n");
        out.print("        <input name=\"aseqno\" maxsize=\"10\" size=\"7\" value=\"" + aseqno + "\" />\n");
        out.print("        <br />\n");
        out.print("        <input type=\"submit\" value=\"Compute\" />\n");
        out.print("      </td><td>\n");
        out.print("        Mode:<br />\n");
        out.print("        <select name=\"mode\" size=\"5\">\n");
        for (int ix = 0; ix < optMode.length; ++ix) {
          out.print("         <option value=\"" + optMode[ix] + "\"" + (optMode[ix].equals(mode) ? " selected" : "")
              +                 ">" + enMode[ix] + "</option>\n");
        }
        out.print("                </select>\n");
        out.print("      </td><td>\n");
        out.print("        Options:<br />");
        out.print("        <input name=\"opt\" maxsize=\"100\" size=\"12\" value=\"" + opt + "\" />\n");
        out.print("        <br /><br />\n");
        out.print("      </td>\n");
        out.print("    </tr>\n");
        out.print("    <tr valign=\"top\">\n");
        out.print("      <td align=\"left\" colspan=\"3\">\n");
        out.print("        <textarea name=\"area\" wrap=\"virtual\" cols=\"" + width + "\" rows=\"" + height + "\">");
        SequenceFactory.compute(new String[] { "-" + mode, "-n", "64", aseqno } , out);
        out.print("        </textarea>\n");
        out.print("      </td>\n");
        out.print("    </tr>\n");
        out.print("  </table>\n");
        out.print("</form><!-- joeis -->\n");
        out.print("<br /><br />\n");
        out.print("See also: ");
        basePage.writeAuxiliaryLinks(language, "main");
        basePage.writeTrailer(language, "quest");
    }
}
