# teardown
teardown: predictor_down mlflow_down

# mlflow
mlflow_up:
	docker-compose -f deployment/mlflow/docker-compose.yml up -d

mlflow_down:
	docker-compose -f deployment/mlflow/docker-compose.yml down

# predictor
predictor_up:
	bash deployment/deploy.sh run_predictor ./data/model_config/phase-1/prob-1/model-1.yaml ./data/model_config/phase-1/prob-2/model-1.yaml 5040

predictor_down:
	PORT=5040 docker-compose -f deployment/model_predictor/docker-compose.yml down

predictor_restart:
	PORT=5040 docker-compose -f deployment/model_predictor/docker-compose.yml stop
	PORT=5040 docker-compose -f deployment/model_predictor/docker-compose.yml start

predictor_curl1:
	curl -X POST http://localhost:5040/phase-1/prob-1/predict -H "Content-Type: application/json" -d @data/curl/phase-1/prob-1/payload-1.json
	curl -X POST http://localhost:5040/phase-1/prob-1/predict -H "Content-Type: application/json" -d @data/curl/phase-1/prob-1/payload-2.json

predictor_curl2:
	curl -X POST http://localhost:5040/phase-1/prob-2/predict -H "Content-Type: application/json" -d @data/curl/phase-1/prob-2/payload-1.json
	curl -X POST http://localhost:5040/phase-1/prob-2/predict -H "Content-Type: application/json" -d @data/curl/phase-1/prob-2/payload-2.json
