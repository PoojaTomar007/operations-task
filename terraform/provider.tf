# Specify the provider (GCP, AWS, Azure)
provider "google" {
  credentials = "${file("black-octagon-334810-d037d767e12b.json")}"
  project     = "black-octagon-334810"
  region      = "us-west4"
}
