###########################################################################################
#FortiManager Create Webfilter URL-Filter4 
###########################################################################################
/*
  resource "fortios_fmg_jsonrpc_request" "webfilter_urlfilter" {
	json_content = <<JSON	
  {
	"method": "add",	
	"params": [	
     {
	  "data": [	
     {
	 "name": "${var.vpc.id}",
	 "entries": [	
      {
	   "id": 1,	
	   "url":"*",	
	   "type": "wildcard",	
	   "action": "block"
       }
       ]
       }	
	],	
	"url": "/pm/config/adom/${var.adom)/obj/webfilter/urlfilter"
    }
  ]
}
JSON
}
*/
