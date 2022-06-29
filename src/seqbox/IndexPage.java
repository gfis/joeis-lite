package seqbox;

import irvine.oeis.SequenceFactory;

import java.io.IOException;
import java.io.OutputStream;
import java.io.Serializable;
import java.util.ArrayList;
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
     * @throws IOException for IO errors
     */
    public void dialog(final HttpServletRequest request, final HttpServletResponse response
            , final BasePage basePage
            , final String language
            ) throws IOException {
        String aseqno   = basePage.getInputField(request, "aseqno"   , "A007318").trim(); // A-number
        String mode     = basePage.getInputField(request, "mode"     , "D"); // how to display the terms (data, b-file, triangle and so on)
        String area     = basePage.getInputField(request, "area"     , ""); // output area for terms
        String offset   = basePage.getInputField(request, "offset"   , "").trim(); // index of first term (needed for  b-files)
        String terms    = basePage.getInputField(request, "terms"    , "64").trim(); // number of terms to be computed
        String rows     = basePage.getInputField(request, "rows"     , "8").trim(); // number of rows for triangles and squares
        String dataLen  = basePage.getInputField(request, "datalen"  , "260").trim(); // character length of data (0 = unlimited)
        String rowNums  = basePage.getInputField(request, "rowNums"  , "").trim(); // whether to display row numbers for triangles and squares 
        String header   = basePage.getInputField(request, "header"   , "").trim(); // whether to display a header at the beginning of the b-file
        String timestamp= basePage.getInputField(request, "timestamp", "").trim(); // whether to display a timestamp before each term
        String priority = basePage.getInputField(request, "priority" , "java,gp").trim().replaceAll(" ","").toLowerCase(); // order for producers
        String author   = basePage.getInputField(request, "author"   , "").trim(); // string to be displayes as author in the header
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
        String[] optMode    = new String []
                { "D"    // 0
                , "B"    // 1
                , "R"    // 2
                , "S"    // 3
                , "T"    // 4
                } ;
        String[] enMode     = new String []
                { "Data section"
                , "B-file"
                , "Upper right triangle"
                , "Square array"
                , "Triangle"
                } ;
        int index = 0;
        out.print("<!-- aseqno=\"" + aseqno + "\", mode=\""  + mode + "\"\n");
        out.print(", terms=\"" + terms + "\", rows=\""  + rows + "\", dataLen=\"" + dataLen + "\"\n");
        out.print(", rowNums=\"" + rowNums + "\", header=\""  + header + "\", timestamp=\"" + timestamp + "\", author=\"" + author + "\"\n");
        out.print("  area=\""  + area + "\"\n");
        out.print("-->\n");
        out.print("<h2>Seqbox - Toolkit for Seqfans</h2>\n");
        out.print("<form action=\"servlet\" method=\"get\">\n");
        out.print("  <input type = \"hidden\" name=\"view\" value=\"joeis\" />\n");
        out.print("  <table cellpadding=\"0\" border=\"" + border + "\">\n");
        out.print("    <tr valign=\"top\">\n");
        out.print("      <td><strong>A-Number:</strong><br />\n");
        out.print("        <strong><a href=\"https://oeis.org/" + aseqno + "\" title=\"OEIS description\" target=\"_blank\">OEIS </a>\n");
        out.print("        <input name=\"aseqno\" maxsize=\"10\" size=\"7\" value=\"" + aseqno + "\" /></strong>\n");
        out.print("        <br /><button type=\"submit\" value=\"Generate\" accesskey=\"g\"><u>G</u>enerate</button>\n");
        out.print("        <br /><br /><a target=\"_blank\" href=\"https://raw.githubusercontent.com/archmageirvine/joeis/master/src/irvine/oeis/" 
            + aseqno.substring(0,4).toLowerCase() + "/" + aseqno + ".java\">Java source</a>\n");
        out.print("      </td><td>\n");
        out.print("        Output Mode:<br />\n");
        out.print("        <select name=\"mode\" size=\"5\">\n");
        for (int ix = 0; ix < optMode.length; ++ix) {
          out.print("         <option value=\"" + optMode[ix] + "\"" + (optMode[ix].equals(mode) ? " selected" : "")
              +                 ">" + enMode[ix] + "</option>\n");
        }
        out.print("                </select>\n");
        out.print("      </td><td>\n");
        out.print("        Options:");
        out.print("        <br /><input name=\"offset\"   maxsize=\"10\" size=\"3\" value=\"" + offset  + "\" /> Offset\n");
        out.print("        <br /><input name=\"terms\"    maxsize=\"10\" size=\"3\" value=\"" + terms   + "\" /> Terms\n");
        out.print("        <br /><input name=\"rows\"     maxsize=\"10\" size=\"3\" value=\"" + rows    + "\" /> Rows\n");
        out.print("        <br /><input name=\"datalen\"  maxsize=\"10\" size=\"3\" value=\"" + dataLen + "\" /> Data characters\n");
        out.print("      </td><td>\n");
        out.print("        <table cellpadding=\"0\" border=\"0\"><tr><td>Author:</td><td><input name=\"author\" maxsize=\"64\" size=\"12\" value=\"" + author + "\" />\n");
        out.print("          </td></tr><tr><td>Priority:</td><td><input name=\"priority\" maxsize=\"64\" size=\"12\" value=\"" + priority + "\" /></td></tr></table>\n");
        out.print("              <input type=\"checkbox\" id=\"rowNums\"   name=\"rowNums\"   value=\"true\"><label for=\"rowNums\" > Row numbers</label>\n");
        out.print("        <br /><input type=\"checkbox\" id=\"header\"    name=\"header\"    value=\"true\"><label for=\"header\"  > B-file header</label>\n");
        out.print("        <br /><input type=\"checkbox\" id=\"timestamp\" name=\"timestamp\" value=\"true\"><label for=\"vehicle3\"> Timestamp</label>\n");
        out.print("      </td>\n");
        out.print("    </tr>\n");
        out.print("    <tr valign=\"top\">\n");
        out.print("      <td align=\"left\" colspan=\"4\">\n");
        int width  = 96;
        int height = 8;
        if (mode.equals("B")) {
          width  = 32;
          height = 64;
        }
        out.print("        <textarea name=\"area\" id=\"myInput\" wrap=\"virtual\" cols=\"" + width + "\" rows=\"" + height + "\">");
        final ArrayList<String> args = new ArrayList<>(16);
        args.add("-" + mode);
        args.add("--terms="       + (terms  .trim().length() == 0 ? "0" : terms  ));
        args.add("--rows="        + (rows   .trim().length() == 0 ? "0" : rows   ));
        args.add("--data-length=" + (dataLen.trim().length() == 0 ? "0" : dataLen));
        args.add("--author="      + (author .trim().length() == 0 ? ""  : author ));
        if (rowNums.equals("true"))   {
          args.add("--row-numbers");
        }
        if (offset.length() > 0)    {
          args.add("--offset=" + offset);
        }
        if (header.equals("true"))    {
          args.add("--header");
        }
        if (timestamp.equals("true")) {
          args.add("--timestamp");
        }
        args.add(aseqno);
        String[] arrs = new String[args.size()];
        arrs = args.toArray(arrs);
        SequenceFactory.compute(arrs, out);
        out.print("        </textarea>\n");
        out.print("        <button onclick=\"myFunction()\" style=\"vertical-align:top;align:right;\" accesskey=\"c\"><u>C</u>opy</button>\n");
        out.print("      </td>\n");
        out.print("    </tr>\n");
        out.print("  </table>\n");
        out.print("</form><!-- joeis -->\n");
        out.print("<br />\n");
        basePage.writeAuxiliaryLinks(language, "main");
        basePage.writeTrailer(language, "quest");
    }
}
