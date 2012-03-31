jQuery ->
	$("#menu_directory a").click ->
		switch @id
			when "add_node"
				$("#display_folders").jstree "create", null, "last", { attr: { rel: "folder" } }
			when "remove_node"
				$("#display_folders").jstree "remove"
			when "rename_node"
				$("#display_folders").jstree "rename"
			else	
				alert "Invalid field."

jQuery ->
	$("#display_folders").jstree(
		plugins:
			["themes","json_data","ui","crrm","dnd","search","types","hotkeys"]

		themes:
			theme: 'default'
			
		types:
			valid_children: "root"
			max_children: 1
			max_depth: 4
			types:
				root: 
					icon:
						image: "http://static.jstree.com/v.1.0rc/_docs/_drive.png"
					start_drag: false
					move_node: false
					delete_node: false
					remove: false
					
				file:
					valid_children: "none"
					icon:
						image: "http://www.jstree.com/static/v.1.0pre/_demo/file.png"
		dnd:
			drag_target: false
			drop_target: false
			
		json_data:
			ajax:
				url: "library/directories.json"
				data: (n) -> id: if n.attr then n.attr("id") else 0
				
		).bind("create.jstree", (e, data) ->
			$.ajax
				async: false
				type: "POST"
				url: "/library/directories.json"
				data:
					id: data.rslt.parent.attr("id")
					name: data.rslt.name

				success: (r) ->
					data.inst.refresh()
					
				error: (r) ->
					$.jstree.rollback(data.rlbk)
					
		).bind("remove.jstree", (e, data) ->			
			$.ajax
				async: false
				type: "DELETE"
				url: "/library/directories/" + data.rslt.obj.attr("id") + ".json"
				data:
					type: data.rslt.obj.attr("rel")
				
				success: (r) ->
					data.inst.refresh()
					
				error: (r) ->
					$.jstree.rollback(data.rlbk)
					
		).bind("rename.jstree", (e, data) ->
			if data.rslt.old_name != data.rslt.new_name
				$.ajax
					async: false
					type: "PUT"
					url: "/library/directories/" + data.rslt.obj.attr("id") + ".json"
					data:
						type: data.rslt.obj.attr("rel")
						name: data.rslt.new_name
				
					success: (r) ->
						data.inst.refresh()
					
					error: (r) ->
						$.jstree.rollback(data.rlbk)
						
		).bind("move_node.jstree", (e, data) ->
				$.ajax
					async: false
					type: "POST"
					url: "/library/directories/" + data.rslt.o.attr("id") + "/move.json"
					data:
						new_parent: data.rslt.np.attr("id")
						old_parent: data.rslt.op.attr("id")
						type: data.rslt.o.attr("rel")
							
					success: (r) ->
						console.log "success: %o", r
						data.inst.refresh()
						
					error: (r) ->
						console.log "error: %o", r
						$.jstree.rollback(data.rlbk)
		)
		