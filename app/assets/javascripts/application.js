// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-wysihtml5
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .

var ready;
ready = function() {
  if(window.location.hash && $(window.location.hash).prev().is("hr")) {
    console.log($(window.location.hash).prev().css(
        {
          "height": "6px",
          "border": "0",
          "box-shadow": "inset 0 6px 6px -6px #ed3e49"
        }
      )
    );
  }
};

$(document).ready(ready);
$(document).on('page:load', ready);
