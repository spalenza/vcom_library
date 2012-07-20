jQuery ->
	$(".library_content .header .search a, #close").click (event) ->
		event.preventDefault()
		$('.advanced_search').slideToggle('slow')

jQuery ->
  $("#search_element_tokens").tokenInput("/elements.json", {
    crossDomain: false
    theme: "facebook"
    deleteText: "&times;"
    preventDuplicates: true
    tokenValue: 'name'
  })
