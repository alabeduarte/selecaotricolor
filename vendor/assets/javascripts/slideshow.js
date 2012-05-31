var Slideshow = new function() {

 var wrapper = $('#slideshow-wrapper', document.getElementById('slideshow')),
  images = $('img', wrapper),
  caption = $('#caption', wrapper),
  index = -1,
  timer = null;
  
 var showImage = function(i) {
  var image = images.eq(i);
  var text = image.attr('alt');
  
  images.hide();
  caption.hide();
  image.effect('drop',
        {
          mode: 'show',
          direction: 'horizontal'
        }, 1000, function() {
   caption.text(text).fadeIn(3000);
   });
 };
 
 var slide = function() {
  timer = setInterval(function() {
   index++;
   if(index == images.length) {
    index = 0;
   }
   showImage(index);
  }, 4000);
 };
 this.init = function() {
  slide();
 };
}();

$(function() {
 Slideshow.init();
});