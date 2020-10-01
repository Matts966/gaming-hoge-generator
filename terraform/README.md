# Infrastructure as Code by terraform

## Setup a instance adn install kubeadm

1. install terraform
2. `terraform init`
3. `gcloud config set project {your-project}`
4. `gcloud auth application-default login`
5. `terraform apply`

## Setup kubernetes cluster with kubeadm

### Get join command on controller node

```bash
sudo kubeadm token create --print-join-command
```

### Workder Node Setup

Use command emmitted by the commands on controller node above like

```bash
sudo kubeadm join 10.240.0.11:6443 --token vazvte.cpc8jurckkoczt67 \
    --discovery-token-ca-cert-hash sha256:9f166b4aaa483b11be7fa96f7c009611396ca4162596aadfba61352e444da1c0
```

## Further Reading

- [Creating a cluster with kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/)
- [Creating Highly Available clusters with kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/)


