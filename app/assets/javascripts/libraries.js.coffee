jQuery ->
	$(".vcom_details .vcom_body .vcom_struct").jstree(
		plugins:
			[ "themes", "html_data", "types" ]

		themes:
			icons: false
	)