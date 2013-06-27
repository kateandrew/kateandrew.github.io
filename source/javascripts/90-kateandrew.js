$(function(){
    $('[rel^=ChillBox]').ChillBox();
    var hash = window.location.hash;
    if (hash) {
        if (hash.indexOf('#') === false) { hash = '#'+hash; }
        //@todo break out into re-usable function
        window.scrollTo(0, 0);
        window.setTimeout(function(){
            $('html, body').animate({
                scrollTop: $(hash).offset().top-100
            }, 600);
        }, 300);
    }
    $('a[href^="#"], a[href^="'+window.location.pathname+'#"]').each(function(){
        var uri  = $(this).attr('href');
        var anchor = uri.substring(uri.indexOf('#'));
        $(this).click(function(){
            $('html, body').animate({
                scrollTop: $(anchor).offset().top-185
            }, 400);
        });
    });
    (function($) {
        $(document).ready( function() {
            $('.e').emailLink();
        } );
    })(jQuery);
});