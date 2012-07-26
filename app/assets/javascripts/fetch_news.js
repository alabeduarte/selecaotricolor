function fetchNews() {
	fetchECBahiaNews();
}

function fetchECBahiaNews() {
	var ecbahiaLogo = 'http://www.ecbahia.com/global/imgs/topo_logo.jpg'
	$('#ec_bahia_feed').css('display', 'block');
	$('#ec_bahia_feed').append($('<img src="' + ecbahiaLogo + '" width="180px" height="30px">'));
	$('#ec_bahia_feed').append($('<ul>'));
	$.getJSON('ecbahia_news.json', function(data) {
		$.each(data, function(i, item){
			$('#ec_bahia_feed ul').append($('<li>'));
			$('#ec_bahia_feed ul li:last').append('<span class="match-day">' + item.date + '</span>');
			$('#ec_bahia_feed ul li:last').append('<a href="' + item.url + '" target="_blank">' + item.title + '</a>');
		});
	});
}