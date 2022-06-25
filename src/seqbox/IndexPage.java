package seqbox;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.util.Iterator;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
/** 
 * Seqbox main dialog page
 * @author Georg Fischer
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
     * @param basePage refrence to common methods and error messages
     * @param language 2-letter code en, de etc.
     * @param area application area: rset
     * @param opt options 
     * @param form1 upper input textarea for RelationSet
     * @param form2 resulting RelationSet
     * @param form2c like <em>form2</em> with colored prime factors
     * @throws IOException for IO errors
     */
    public void dialog(final HttpServletRequest request, final HttpServletResponse response
            , final BasePage basePage
            , final String language
            , final String area
            , final String opt
            , final String form1
            , final String form2
            , final String form2c
            ) throws IOException {
            PrintWriter out = basePage.writeHeader(request, response, language);
            out.write("<title>" + basePage.getAppName() + " Main Page</title>\n");
            out.write("</head>\n<body>\n");

            String border = "0";
            int width  = 100;
            int height = 2;
            String[] optArea    = new String []
                    { "rset"    // 0
                    , "cfra"    // 1
                    , "eecj"    // 2
                    } ;
            String[] enArea     = new String []
                    { "Symbolic RelationSet"        // 0
                    , "Continued Fraction"          // 1
                    , "Euler's Extended Conjecture" // 2
                    } ;
            int index = 0;
            out.write("<!-- area=\""  + area + "\", opt=\"" + opt + "\"\n");
            out.write("    form1=\""  + form1 + "\"\n");
            out.write("    form2=\""  + form2 + "\"\n");
            out.write("-->\n");
            out.write("<h2>Seqbox - Toolkit for Seqfans</h2>\n");
            out.write("<form action=\"servlet\" method=\"get\">\n");
            out.write("    <input type = \"hidden\" name=\"view\" value=\"upper\" />\n");
            out.write("    <table cellpadding=\"0\" border=\"" + border + "\">\n");
            out.write("        <tr valign=\"top\">\n");
            out.write("            <td><strong>Area:</strong><br />\n");
            out.write("                <select name=\"area\" size=\"3\">\n");
            index = 0;
            while (index < optArea.length) {
                out.write("<option value=\"" + optArea[index] + "\""
                        + (optArea[index].equals(area) ? " selected" : "")
                        + ">" + enArea[index] + "</option>\n");
                index ++;
            } // while index
            out.write("                </select>\n");
            out.write("                <br />\n");
            out.write("                <br />\n");
            out.write("                <strong>Options:</strong> ");
            out.write("                <input name=\"opt\" maxsize=\"100\" size=\"12\" value=\"" + opt + "\" />\n");
            out.write("                <br /><br />\n");
            out.write("            </td>\n");
            
            out.write("        </tr>\n");
            out.write("        <tr valign=\"top\">\n");
            out.write("            <td align=\"left\" colspan=\"2\"><strong>RelationSet:</strong><br />\n");
            out.write("                <textarea name=\"form1\" wrap=\"virtual\" cols=\"" + width + "\" rows=\"" + height + "\">"
                                       + form1 + "</textarea>\n");
            out.write("            </td>\n");
            out.write("        </tr>\n");
            out.write("        <tr valign=\"top\">\n");
            out.write("            <td align=\"left\" colspan=\"2\">\n");
            out.write("                <input type=\"submit\" value=\"Compute\" /> with substitutions\n");
            out.write("            </td>\n");
            out.write("        </tr>\n");
            out.write("    </table>\n");
            out.write("</form><!-- upper -->\n");
            
            out.write("<form action=\"servlet\" method=\"get\">\n"); // lower
            out.write("    <input type = \"hidden\" name=\"view\"  value=\"lower\" />\n");
            out.write("    <input type = \"hidden\" name=\"area\"  value=\"" + area  + "\" />\n");
            out.write("    <input type = \"hidden\" name=\"opt\"   value=\"" + opt   + "\" />\n");
            out.write("    <input type = \"hidden\" name=\"form2\" value=\"" + form2 + "\" />\n");
            out.write("    <table cellpadding=\"0\" border=\"" + border + "\">\n");
            out.write("        <tr valign=\"top\">\n");
            out.write("            <td>" + form2c + "</td>\n");
            out.write("        </tr>\n");
            out.write("        <tr valign=\"top\">\n");
            out.write("            <td align=\"left\">\n");
            out.write("                <input type=\"submit\" value=\"Replace\" /> input field\n");
            out.write("            </td>\n");
            out.write("        </tr>\n");
            out.write("    </table>\n");
            out.write("</form><!-- lower -->\n");
            out.write("                <br />\n");

            out.write("See also: ");
            basePage.writeAuxiliaryLinks(language, "main");
            basePage.writeTrailer(language, "quest");
    }
}
