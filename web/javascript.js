/*  Common JavaScript functions
    @(#) $Id$
    2022-06-26, Georg Fischer: copied from dbat
*/

// from https://qawithexperts.com/article/javascript/creating-copy-to-clipboard-using-javascript-or-jquery/364
function copyToClipboard(text) {
    var sampleTextarea = document.createElement("textarea");
    document.body.appendChild(sampleTextarea);
    sampleTextarea.value = text; //save main text in it
    sampleTextarea.select(); //select textarea contenrs
    document.execCommand("copy");
    document.body.removeChild(sampleTextarea);
}

function myFunction(){
    var copyText = document.getElementById("myInput");
    copyToClipboard(copyText.value);
}

function showImage(imagename, width) {
    document.write('<img src="' + imagename + '" width="' + width + '" title="' + imagename + '" />');
} // showImage

function mailtoLink(mailAddr, subject, body) { // surround a mail address by an <a href="mailto:..."> tag
    if (mailAddr != "undefined" && mailAddr.length > 0) { // non-empty
        document.write('<a href="mailto:' + mailAddr);
        if (subject != "undefined") {
            document.write("?subject=" + subject);
            if (body != "undefined") {
                document.write("\&body=" + body);
            } // with body
        } // with subject
        document.write('">' + mailAddr + '</a>');
    } // with mailAddr
} // mailtoLink

function url(link, show, target) { // surround an URL by an <a href="..."> tag
    if (show   === undefined || show.length   == 0) {
        show   = link;
    }
    if (link   !== undefined && link.length     > 0) { // non-empty
        document.write('<a href="' + link);
        if (false) {
        } else if (target === undefined) {
            document.write('" target="_blank');
        } else if (target.length > 0) {
            document.write('" target="' + target);
        } else { // length == 0
            // ignore, "" -> no target
        }
        document.write('">' + show + '</a>');
    } // non-empty
} // generalLink
