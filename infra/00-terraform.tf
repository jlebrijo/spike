variable "digitalocean_token" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "${var.digitalocean_token}"
}

resource "digitalocean_kubernetes_cluster" "mycluster" {
  name    = "mycluster"
  region  = "ams3"
  // Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.16.2-do.1"

  node_pool {
    name       = "mypool"
    size       = "s-1vcpu-2gb"
    auto_scale = "true"
    node_count = 1
    min_nodes  = 1
    max_nodes  = 10
    tags       = ["mypool-nodes"]
  }
}

resource "local_file" "kubernetes_config" {
  content = "${digitalocean_kubernetes_cluster.mycluster.kube_config.0.raw_config}"
  filename = "kubeconfig.yaml"
}

resource "digitalocean_loadbalancer" "public" {
  name = "lb-1"
  region = "ams3"

  forwarding_rule {
    entry_port = 80
    entry_protocol = "http"

    target_port = 30000
    target_protocol = "http"
  }

  healthcheck {
    port = 30000
    protocol = "tcp"
  }

  // This connects LB:30000 with mypool:30000
  droplet_tag = "mypool-nodes"
}

// Comment for existing domains
//resource "digitalocean_domain" "lebrijo" {
//  name = "lebrijo.com"
//}

# Add a record to the domain
resource "digitalocean_record" "www" {
  domain = "lebrijo.com"
  type   = "A"
  name   = "test"
  ttl    = "40"
  value  = "${digitalocean_loadbalancer.public.ip}"
}
