resource "google_artifact_registry_repository" "spotmusic-repo" {
  provider = google-beta

  location = "us-west1"
  repository_id = "hackaton-infra"
  description = "Imagens Docker"
  format = "DOCKER"
}

resource "google_sql_database" "database" {
  name     = "my-spotmusic-db"
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_database_instance" "instance" {
  name             = "my-spotmusic-instance"
  region           = "us-central1"
  database_version = "MYSQL_8_0"
  settings {
    tier = "db-f1-micro"
  }

  deletion_protection  = "true"
}

resource "google_sql_user" "users" {
  name = "root"
  instance = google_sql_database_instance.instance.name
  host = "%"
  password = "spotmusic"
}