// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require ide/parser_rules/advanced
//= require ide/vendor/modernizr
//= require ide/terminal
//= require ide/dist/wysihtml5-0.3.0
//= require ide/events
//= require ide/staticPages
//= require ide/main
// = require ide/pageContent

    function resetPage(){
      pushObject = $('li[data-page="page"][data-code="about"');
      pushObject.click();
    }
  $(window).load(function(){
    function reloadPage(){
      pageUrl = window.location.pathname.split('/');
      if(pageUrl.length<4)
      {
        pushObject = $('li[data-page="page"][data-code="about"');
        pushObject.click();
      }
      else
      {
        type = pageUrl[pageUrl.length-2];
        name = pageUrl[pageUrl.length-1];
        pushObject = $('li[data-page='+ type + '][data-code=' + name + ']');
        pushObject.click();
        // console.log(pushObject);
      }
    }
    reloadPage();
    $(window).on('popstate',function(){
      // window.history.back();
      reloadPage();
    });
    if($('.nav_entry').length < 1)
    {
      window.location.reload();
    }
  });