# Spike

Rails 6 based app implementing usual specs for production web apps:

- [x] Continuous Development: Guard
- [x] Template engine: Haml
- [x] Authentication: Login with Devise
- [x] Database: PostgreSQL
- [x] Basic Design: Bootstrap + Fontawesome
- [x] Tests: Models, views, API
- [x] REST API
- [x] CRUD SPA: Stimulus
- [x] Wysiwyg Editor
- [x] File Uploading
- [x] Sending Emails with design
- [x] API DOC: Swagger
- [x] Reports: PDF with templates. Linked and mail attached.

Deployment:
- [x] Containerizing: Dockerfile and docker-compose (with production env)
- [x] Deploying scripts from local ==> Docker and Kubernetes
- [ ] Debug scripts: ssh, restore db and rails console
- [ ] CDN storage (S3, Spaces DO): for file uploading, asset pipeline, email assets
- [ ] HTTPS (DO Load Balancers)
- [ ] CI/CD (CircleCI)
- [ ] Monitor / Alerts
- [ ] Exceptions notifiation

TODO:
- [ ] Performance: Skylight
- [ ] Load test

## Infrastructure

### Installation

Open `cd infra` folder to operate.

Provision infrastructure:
* Add DO valid token to `terraform.tfvars`
* `terraform init; terraform apply`

Create kube elements:
* `mv kubeconfig.yaml ~/.kube/config`
* `kubectl apply -f 01-postgresql.yml` creates database in a volume and service
* `kubectl apply -f 02-rails-env.yml` creates rails env variables
* `kubectl apply -f 03-rails-app.yml` creates rails app
* `watch kubectl get all` check all is created

Initialize database with a job:
* `kubectl apply -f 04-db-setup-job.yml` db setup with a job
* `kubectl logs job/setup` check everything went right
* `kubectl delete job/setup` removes job

Automate provisioning:
* `./bin/provision` creates all infrastructure
* `cd infra;terraform destroy -auto-approve` destroys infrasatructure

### Deployments

Redeployments:
* `docker build -t jlebrijo/spike .` build image with changes.
* `docker push jlebrijo/spike` publish image.
* `kubectl apply -f 04-migration-job.yml` runs migration.
* `kubectl wait --for=condition=complete --timeout=600s job/migrate` wait completion before to continue.
* `kubectl logs job/migrate` check everything went right.
* `kubectl delete job/migrate` removes job.
* `kubectl rollout restart deployment/rails` redeploy rails deployment.

Automating redeployments:
* `./bin/deploy` run migrations and redeployment

