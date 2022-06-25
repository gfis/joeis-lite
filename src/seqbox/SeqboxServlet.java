package seqbox;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** Seqbox - Web interface for jOEIS programs.
 *  @author Dr. Georg Fischer
 */
public class SeqboxServlet extends HttpServlet {
    public final static long serialVersionUID = 19470629;

    /** URL path to this application */
    private String mApplPath;
    /** Common code and messages for auxiliary web pages */
    private BasePage mBasePage;
    /** Name of this application */
    private static final String APP_NAME = "Seqbox";

    /** 
     * Called by the servlet container to indicate to a servlet
     * that the servlet is being placed into service.
     * @param config object containing the servlet's configuration and initialization parameters
     * @throws ServletException for servlet errors
     */
    public void init(final ServletConfig config) throws ServletException {
        super.init(config); // ???
        mBasePage = new BasePage(APP_NAME);
        Messages.addMessageTexts(mBasePage);
    } // init

    /** 
     * Process an http GET request
     * @param request request with header fields
     * @param response response with writer
     * @throws IOException for IO errors
     */
    public void doGet (final HttpServletRequest request, final HttpServletResponse response) throws IOException {
        generateResponse(request, response);
    }

    /** 
     * Process an http POST request
     * @param request request with header fields
     * @param response response with writer
     * @throws IOException for IO errors
     */
    public void doPost(final HttpServletRequest request, final HttpServletResponse response) throws IOException {
        generateResponse(request, response);
    }

    /** 
     * Generate the response (HTML page) for an http request
     * @param request request with header fields
     * @param response response with writer
     * @throws IOException for IO errors
     */
    public void generateResponse(final HttpServletRequest request, final HttpServletResponse response) throws IOException {
        String view     = BasePage.getInputField(request, "view"  , "");
        String area     = BasePage.getInputField(request, "area"  , "rset");
        String opt      = BasePage.getInputField(request, "opt"   , "norm");
        String form1    = BasePage.getInputField(request, "form1" , "(a-b)^3");
        String form2    = BasePage.getInputField(request, "form2" , "");
        String form2c   = BasePage.getInputField(request, "form2c", ""); // HTML colored
        String language = "en";
        int index = 0;
        boolean found = false;
        int mode = 3; // with PrimeFactorization and HTML coloring
        String newPage = null;
        try {
            if (false) {
            } else if (view.equals("upper")
                    || view.equals("index")
                    ) {
                if (false) {
                } else if (area.equals("rset")) {
                    index = 0;
                    found = true;
                    while (found) {
                        String key   = request.getParameter("key" + String.valueOf(index));
                        String value = request.getParameter("val" + String.valueOf(index));
                        if (key == null || value == null) {
                            found = false;
                        }
                        index ++;
                    } // while found
                    if (opt.indexOf("norm") >= 0) {
                        //** rset.deflateIt();
                    }
                    //** form2  =  rset.toString(mode);
                    //** form2c =  rset.toString(mode + 1) + "<br />" + rset.toString(0);
                    (new IndexPage    ()).dialog(request, response, mBasePage, language, area, opt, form1, form2, form2c);
                } else { // invalid area
                    mBasePage.writeMessage(request, response, language, new String[] { "401", "area", area });
                }

            } else if (view.equals("lower")) {
                if (false) {
                } else if (area.equals("rset")) {
                    //** rset = RelationSet.parse(form2);
                    //** rmap = rset.getRefiningMap("x"); // maps x -> name
                    index = 0;
                    found = true;
                    while (found) {
                        String key   = request.getParameter("key" + String.valueOf(index));
                        String value = request.getParameter("val" + String.valueOf(index));
                        if (key == null || value == null) {
                            found = false;
                        }
                        index ++;
                    } // while found
                    if (opt.indexOf("norm") >= 0) {
                        //** rset.deflateIt();
                    }
                    //** form1 = rset.toString(mode);
                    (new IndexPage()).dialog(request, response, mBasePage, language, area, opt, form1, form2, form2c);
                } else {
                    mBasePage.writeMessage(request, response, language, new String[] { "401", "area", area });
                }

            } else if (view.equals("license")
                    || view.equals("manifest")
                    || view.equals("notice")
                    ) {
                (new MetaInfPage    ()).showMetaInf (request, response, mBasePage, language, view, this);

            } else {
                mBasePage.writeMessage(request, response, language, new String[] { "401", "view", view });
            }
        } catch (IOException exc) {
            System.err.println(exc.getMessage());
            throw exc;
        }
    }
}
