function fetchNews() {
	fetchECBahiaNews();
	fetchGloboEsporteNews();
	setInterval('refreshECBahiaNews()', 7200000); // 2 hours
	setInterval('refreshGloboEsporteNews()', 7200000); // 2 hours
}

function fetchECBahiaNews() {
	var logo = 'http://www.ecbahia.com/global/imgs/topo_logo.jpg'
	$('#ec_bahia_feed').css('display', 'block');
	var imgLogo = $('<img title="Atualizar" src="' + logo + '" width="180px" height="30px">');
	imgLogo.css('cursor', 'pointer');
	imgLogo.click(function(){
		refreshECBahiaNews();
	});
	$('#ec_bahia_feed').append(imgLogo);
	$('#ec_bahia_feed').append($('<ul>'));
	$.getJSON('ecbahia_news.json', function(data) {
		$.each(data, function(i, item){
			$('#ec_bahia_feed ul').append($('<li>'));
			$('#ec_bahia_feed ul li:last').append('<span class="match-day">' + item.date + '</span>');
			$('#ec_bahia_feed ul li:last').append('<a href="' + item.url + '" target="_blank">' + item.title + '</a>');
		});
		$('#loader-left').hide();
	});
}

function refreshECBahiaNews() {
	$('#ec_bahia_feed').html('');
	$('#loader-left').show();
	fetchECBahiaNews();
}

function fetchGloboEsporteNews() {
	var logo = 'http://s.glbimg.com/es/ge/static/globoesporte/img/logo-globoesporte-internas.png?2e69862f0df7'
	$('#globoesporte_feed').css('display', 'block');
	var imgLogo = $('<img title="Atualizar" class="globoesporte-logo" src="' + logo + '" width="80px" height="50px">');
	imgLogo.css('cursor', 'pointer');
	imgLogo.click(function(){
		refreshGloboEsporteNews();
	});
	
	$('#globoesporte_feed').append(imgLogo);
	$('#globoesporte_feed').append($('<ul>'));
	$('#globoesporte_thumbs').append($('<ul>'));
	$.getJSON('globoesporte_news.json', function(data) {
		$.each(data, function(index, item){
			$('#globoesporte_feed ul').append($('<li>'));
			$('#globoesporte_thumbs ul').append($('<li>'));
			var description = $.trim(item.title);
			
			var urlId = 'url_' + index;
			var link = $('<a id="' + urlId + '" href="' + item.url + '" target="_blank">' + description + '</a>');
			$('#globoesporte_feed ul li:last').append(link);
			
			var imageId = 'image_' + index;
			var image = $('<img id="'+ imageId +'" title="'+ description +'" alt="'+ description +'" class="globoesporte-thumbs" src="' + item.image + '" width="153px" height="96px">');
			$('#globoesporte_thumbs ul li:last').append(image);
			
			$("#" + imageId).click(function () {
				window.open(item.url);
			});
			addHoverEvent("#" + imageId, "#" + urlId);
			addHoverEvent("#" + urlId, "#" + imageId);
		});
		$('#loader-right').hide();
	});
}

function refreshGloboEsporteNews() {
	$('#globoesporte_feed').html('');
	$('#globoesporte_thumbs').html('');
	$('#loader-right').show();
	fetchGloboEsporteNews();
}

function addHoverEvent(sourceId, targetId) {
	$(sourceId).mouseover(function () {
		$(targetId).addClass('hovered');
	});
	$(sourceId).mouseout(function () {
		$(targetId).removeClass('hovered');
	});
}