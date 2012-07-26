function fetchNews() {
	fetchECBahiaNews();
}

function fetchECBahiaNews() {
	var logo = 'http://www.ecbahia.com/global/imgs/topo_logo.jpg'
	$('#ec_bahia_feed').css('display', 'block');
	$('#ec_bahia_feed').append($('<img src="' + logo + '" width="180px" height="30px">'));
	$('#ec_bahia_feed').append($('<ul>'));
	$.getJSON('ecbahia_news.json', function(data) {
		$.each(data, function(i, item){
			$('#ec_bahia_feed ul').append($('<li>'));
			$('#ec_bahia_feed ul li:last').append('<span class="match-day">' + item.date + '</span>');
			$('#ec_bahia_feed ul li:last').append('<a href="' + item.url + '" target="_blank">' + item.title + '</a>');
		});
	});
}

function fetchGloboEsporteNews() {
	var logo = 'http://s.glbimg.com/es/ge/static/globoesporte/img/logo-globoesporte-internas.png?2e69862f0df7'
	$('#globoesporte_feed').css('display', 'block');
	$('#globoesporte_feed').append($('<img src="' + logo + '" width="180px" height="30px">'));
	$('#globoesporte_feed').append($('<ul>'));
	$.getJSON('globoesporte_news.json', function(data) {
		$.each(data, function(i, item){
			$('#globoesporte_feed ul').append($('<li>'));
			$('#globoesporte_feed ul li:last').append('<a href="' + item.url + '" target="_blank">' + item.title + '</a>');
		});
	});
}