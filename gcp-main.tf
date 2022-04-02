resource "google_artifact_registry_repository" "spotmusic-repo" {
  provider = google-beta

  location = "us-central1"
  repository_id = "hackaton-infra"
  description = "Imagens Docker"
  format = "DOCKER"
}

resource "google_sql_database_instance" "master" {
  name = "spot_music_instance"
  database_version = "MYSQL_8_0"
  location_id = "us-central"
  settings {
    tier = "db-n1-standard-2"
  }
}

resource "google_sql_database" "database" {
  name = "spot_music_db"
  instance = "spot_music_instance"
  charset = "utf8"
  collation = "utf8_general_ci"
}

resource "google_sql_user" "users" {
  name = "root"
  instance = "spot_music_instance"
  host = "%"
  password = "spotmusic"
}