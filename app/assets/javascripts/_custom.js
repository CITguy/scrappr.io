$("a.popup-link").on("click", function () {
    specs = "left=20,top=20,width=700,height=600,toolbar=0";
    window.open( $(this).attr('href'), "popup", specs);
    return false;
});
