#
resource "google_project_service" "project" {
  count = "${length(var.services_list)}"
  project = "${var.project_id}"
  service  = "${element(var.services_list,count.index)}"
}
