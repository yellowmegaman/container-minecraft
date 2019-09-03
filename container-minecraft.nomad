job "mc" {
  datacenters = ["mc"]
  type = "service"
  group "mc" {
    update {
      stagger = "10s"
      max_parallel = 1
    }
    count = "1"
    restart {
      attempts = 5
      interval = "5m"
      delay = "25s"
      mode = "delay"
    }
    task "drone" {
      kill_timeout = "180s"
      env {
        EULA = "true"
      }
      driver = "docker"
      config {
        logging {
            type = "syslog"
            config {
              tag = "${NOMAD_JOB_NAME}${NOMAD_ALLOC_INDEX}"
            }
        }
        network_mode       = "host"
        force_pull         = true
        image              = "yellowmegaman/container-minecraft:1.12.2-14.23.5.2844"
        hostname           = "${attr.unique.hostname}"
        dns_servers        = ["${attr.unique.network.ip-address}"]
        dns_search_domains = ["consul","service.consul","node.consul"]
        volumes            = [
          "/opt/minecraft/world:/opt/minecraft/world",
          "/opt/minecraft/mods:/opt/minecraft/mods",
          "/opt/minecraft/server.properties:/opt/minecraft/server.properties"
        ]
      }
      resources {
        memory  = "6656"
        network {
          mbits = 10
          port "healthcheck" { static = "25565" }
        } #network
      } #resources
      service {
        name = "drone"
        tags = ["1.12.2-14.23.5.2844"]
        port = "healthcheck"
        check {
          name     = "drone-internal-port-check"
          port     = "healthcheck"
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        } #check
      } #service
    } #task
  } #group
} #job
