// $(function () {
// 	$("#folder_directory").jstree({ 
// 		"json_data" : {
// 			"data" : [
// 				{ 
// 					"data" : "A node", 
// 					"metadata" : { id : 23 },
// 					"children" : [ 
// 						{
// 							"data": "Child 1",
// 							"metadata" : { id : 24 }
// 						}, "A Child 2" ]
// 				},
// 				{ 
// 					"attr" : { "id" : "li.node.id1" }, 
// 					"data" : { 
// 						"title" : "Long format demo", 
// 						"attr" : { "href" : "#" } 
// 					} 
// 				}
// 			]
// 		},
// 		"plugins" : [ "themes", "json_data", "ui" ]
// 	}).bind("select_node.jstree", function (e, data) { alert(data.rslt.obj.data("id")); });
// });

// $(function () {
// 	$("#display_folders").jstree({ 
// 		"types" : {
// 			"valid_children" : [ "root" ],
// 			"types" : {
// 				"root" : {
// 					"icon" : { 
// 						"image" : "http://static.jstree.com/v.1.0rc/_docs/_drive.png" 
// 					},
// 					"valid_children" : [ "default" ],
// 					"max_depth" : 2,
// 					"hover_node" : false,
// 					"select_node" : function () {return false;}
// 				},
// 				"default" : {
// 					"valid_children" : [ "default" ]
// 				}
// 			}
// 		},
// 		"json_data" : {
// 			"data" : [
// 				{ 
// 					"data" : "A node", 
// 					"metadata" : { id : 23 },
// 					"children" : [ 
// 						{
// 							"data": "Child 1",
// 							"metadata" : { id : 24 }
// 						}, "A Child 2" ]
// 				},
// 				{ 
// 					"attr" : { "id" : "li.node.id1", "rel" : "root" }, 
// 					"data" : { 
// 						"title" : "Long format demo", 
// 						"attr" : { "href" : "#" } 
// 					} 
// 				}
// 			]
// 		},
// 		"plugins" : ["themes","json_data","dnd","ui","types"]
// 	}).bind("select_node.jstree", function (e, data) { alert(data.rslt.obj.data("id")); });
// });


$(function () {
	$("#display_folders").jstree({ 
		"json_data" : {
			"ajax" : {
				"url" : "/library/directory.json",
				"data" : function (n) { 
					return { id : n.attr ? n.attr("id") : 0 }; 
				}
			}
		},
		"types" : {
			"valid_children" : [ "root" ],
			"types" : {
				"root" : {
					"icon" : { 
						"image" : "http://static.jstree.com/v.1.0rc/_docs/_drive.png" 
					},
					"valid_children" : [ "default" ],
					"max_depth" : 2,
					"hover_node" : false,
					"select_node" : function () {return false;}
				},
				"file" : {
					"valid_children" : "none",
					"icon" : {
						"image" : "http://www.jstree.com/static/v.1.0pre/_demo/file.png"
					},
				},
				"default" : {
					"valid_children" : [ "default" ]
				}
			}
		},
		"plugins" : ["themes","json_data","dnd","ui","types"]
	});
});

