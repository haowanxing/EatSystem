function openpic(url, name, w, h)
{
    window.open(url, name, "top=100,left=400,width=" + w + ",height=" + h + ",toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no");
}
function http_pic(pic) {
    if (pic.indexOf("http://") >= 0) {
        return pic;
    }
    else {
        return './' + pic;
    }
}