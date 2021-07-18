terraform {
  required_providers {
    spotify = {
      version = "~> 0.1.5"
      source  = "conradludgate/spotify"
    }
  }
}

variable "spotify_api_key" {
  type = string
}

provider "spotify" {
  api_key = var.spotify_api_key
}

resource "spotify_playlist" "playlist" {
  name        = "Terraform Summer Playlist"
  description = "This playlist was created by Terraform"
  public      = true

  tracks = [
    data.spotify_search_track.by_artist.tracks[0].id,
    data.spotify_track.road_url.id,
    data.spotify_track.stranger_url.id,
  ]
}

data "spotify_search_track" "by_artist" {
  artists = ["Ben Böhmer"]
  name  = "Beyond Beliefs"
}

data "spotify_track" "road_url" {
  url = "https://open.spotify.com/track/6kckNpuM5oXZrObLExRg6d?si=11349edbe05e4f98"
}

data "spotify_track" "stranger_url" {
  url = "https://open.spotify.com/track/3z3EmPMVgbMABeB43DzwZq?si=938b2f8ed6ed477f"
}


output "tracks" {
  value = data.spotify_search_track.by_artist.tracks
}
