MANIFESTS_JSON=$(curl https://api.github.com/repos/Matts966/gaming-hoge-generator/contents/manifests)
NUM=$(echo $json | jq length)

for i in $( seq 0 $(($NUM - 1)) ); do
  sudo kubectl apply -f $(echo $json | jq .[$i].download_url)
done
