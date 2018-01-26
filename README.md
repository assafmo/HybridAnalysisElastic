# HybridAnalysisElastic

Scrape https://hybrid-analysis.com and index in elasticsearch.

## Installation

```bash
sudo apt install -y curl pv jq parallel lynx
sudo docker run --name elastic -d --restart always -p 9200:9200 docker.elastic.co/elasticsearch/elasticsearch-oss:6.1.2
sudo docker run --name kibana --link elastic:elasticsearch -d --restart always -p 5601:5601 docker.elastic.co/kibana/kibana-oss:6.1.2 # optional
```

## Usage

```bash
./download.sh
./index.sh
```

And go to http://localhost:5601 to explore in kibana.

## License

[MIT](/LICENSE)
