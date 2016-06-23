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
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .


var ready;
ready = function() {
jQuery.LiveAddress({
	key: "27083759696426788",
	target: "US",
	autoVerify: false,
	autocomplete: 5,
	geolocate: true,
	geolocate_precision: "city",
 	addresses: [{
 		address1: "#street-address",
 		locality: "#city",
 		administrative_area: "#state",
 		postal_code: "#zip"
 	}]
 });
};
$(document).ready(ready);