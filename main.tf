terraform {
  # Note: the following lines should be uncommented in order to store Terraform
  # state in a remote backend.

  backend "gcs" {
   bucket = "sandbox-433522-storage-bucket"
   prefix = "buildartifacts/tfplan"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.36"
    }
  }
}

provider "google" {
  project = "sandbox-433522"
  region  = "us-central1" # Adjust the region as needed
}

resource "google_storage_bucket" "my_bucket" {
  name                        = "my-sample-bucket-sandbox-433522"  # Bucket name must be globally unique
  location                    = "US"  # Specify the location for the bucket
  force_destroy               = true  # Set to true to allow bucket deletion with objects inside
  uniform_bucket_level_access = true  # Enable uniform access

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 365  # Delete objects older than 365 days
    }
  }

  versioning {
    enabled = true  # Enable versioning for objects in the bucket
  }

  logging {
    log_bucket        = "your-log-bucket"  # Specify a bucket to store access logs
    log_object_prefix = "log/"  # Prefix for log objects
  }
}

output "bucket_name" {
  value = google_storage_bucket.my_bucket.name
}
