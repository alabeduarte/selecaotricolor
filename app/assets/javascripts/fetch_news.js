function fetch_breaking_news() {
	var ecbahiaLogo = 'http://www.ecbahia.com/global/imgs/topo_logo.jpg'
	$('#feed').css('display', 'block');
	$('#feed').append($('<h1 class="subtitle">'));
	$('#feed h1').append('Notícias do Esquadrão de Aço');
	$('#feed').append($('<img src="' + ecbahiaLogo + '" width="280px" height="45px">'));
	$('#feed').append($('<ul>'));
	$('#feed').append($('<a id="close_feed" class="close notice"><span>×</span></a>'));
	$.getJSON('breaking_news.json', function(data) {
		$.each(data, function(i, item){
			$('#feed ul').append($('<li>'));
			$('#feed ul li:last').append('<span class="match-day">' + item.date + '</span>');
			$('#feed ul li:last').append('<a href="' + item.url + '" target="_blank">' + item.title + '</a>');
		});
	});
	$('#close_feed').click(function() {
		console.log('foi');
		$('#feed').toggle();
	});
}