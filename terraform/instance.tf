resource "google_compute_instance" "gaming-hoge-controller" {
  name         = "gaming-hoge-controller"
  machine_type = "e2-small"
  zone         = "us-west1-a"
  description  = "gaming-hoge-controller"
  tags         = ["gaming-hoge", "public-controller"]
  can_ip_forward = true
  
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size  = "30"
      type  = "pd-standard"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.gaming-hoge-subnet.name
    network_ip = "10.240.0.11"

    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = <<-EOT
    sudo apt update
    sudo apt upgrade -y
    sudo apt install -y docker.io wireguard jq golang-go
    sudo groupadd docker 
    sudo usermod -aG docker $USER
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo apt install -y apt-transport-https curl
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
    sudo apt-get update
    sudo apt-get install -y kubelet kubeadm kubectl
    sudo apt-mark hold kubelet kubeadm kubectl

    sudo kubeadm init --pod-network-cidr 192.168.0.0/16
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config
    kubectl taint nodes $(hostname) node-role.kubernetes.io/master:NoSchedule-

    curl https://docs.projectcalico.org/manifests/calico.yaml -O
    kubectl apply -f calico.yaml

    echo KUBECONFIG=$HOME/.kube/config >> $HOME/.bashrc

    mkdir $HOME/go
    echo GOPATH=$HOME/go >> $HOME/.bashrc
    echo PATH=\$PATH:$HOME/go/go/bin >> $HOME/.bashrc
    source $HOME/.bashrc
    go get -u github.com/squat/kilo/cmd/kgctl
  EOT
}

resource "google_compute_instance" "gaming-hoge-worker-0" {
  name         = "gaming-hoge-worker-0"
  machine_type = "e2-small"
  zone         = "us-west1-b"
  description  = "gaming-hoge-controller"
  tags         = ["gaming-hoge", "public-worker"]
  can_ip_forward = true
  
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size  = "30"
      type  = "pd-standard"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.gaming-hoge-subnet.name
    network_ip = "10.240.0.20"

    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = <<-EOT
    sudo apt update
    sudo apt upgrade -y
    sudo apt install -y docker.io wireguard
    sudo groupadd docker 
    sudo usermod -aG docker $USER
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo apt install -y apt-transport-https curl
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
    sudo apt-get update
    sudo apt-get install -y kubelet kubeadm kubectl
    sudo apt-mark hold kubelet kubeadm kubectl
  EOT
}

resource "google_compute_instance" "gaming-hoge-worker-1" {
  name         = "gaming-hoge-worker-1"
  machine_type = "e2-small"
  zone         = "us-west1-c"
  description  = "gaming-hoge-controller"
  tags         = ["gaming-hoge", "public-worker"]
  can_ip_forward = true
  
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size  = "30"
      type  = "pd-standard"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.gaming-hoge-subnet.name
    network_ip = "10.240.0.21"

    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = <<-EOT
    sudo apt update
    sudo apt upgrade -y
    sudo apt install -y docker.io wireguard
    sudo groupadd docker 
    sudo usermod -aG docker $USER
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo apt install -y apt-transport-https curl
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
    sudo apt-get update
    sudo apt-get install -y kubelet kubeadm kubectl
    sudo apt-mark hold kubelet kubeadm kubectl
  EOT
}
