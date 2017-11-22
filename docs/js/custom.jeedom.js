console.log('Début chargement custom.jeedom.js');

(function($) {
        $.fn.customJS = function(settings) {
          console.log('Début fonction customJS');
                var config = {
                    menuType: 1,
                    numTitre: true
                };

                if (settings) {
                    $.extend(config, settings);
                }
                
                var contTitres = $(this);
   console.log('contTitres', contTitres);
                if(config.numTitre){
                        var i = 1;
                        var j = 1;
                        $('h1, h2', contTitres).each(function(){
                                if($(this)[0].tagName.toLowerCase() == 'h1'){
                                        $('#'+$(this).attr('id')).text(i + '. ' + $(this).text());
                                        i++;
                                }
                                
                                if($(this)[0].tagName.toLowerCase() == 'h2'){
                                        $('#'+$(this).attr('id')).text( (i-1) + '.' + j + ' ' + $(this).text()); 
                                        j++;
                                }else{
                                        j = 1;
                                }
                        });
                        
                       
                
                }
        };
        return this;
//console.log('appel $(#main_content).toc();');
//    $('#main_content').toc();
})(jQuery);
