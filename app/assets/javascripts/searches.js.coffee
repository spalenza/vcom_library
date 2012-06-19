jQuery ->
	$(".library_content .header .search a, #close").click (event) ->
		event.preventDefault()
		$('.advanced_search').slideToggle('slow')
