output "group_response_all" {
 value = jsondecode(forimanager_json_generic_api.find_profile_group.response)
}