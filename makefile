USER=hkozu
STACK=$(USER)-ec2-stack-full
BUCKET=$(USER)-s3-bucket
REGION=eu-central-1
TEMPLATE="cloudformation_template.yaml"
CAPABILITIES=CAPABILITY_NAMED_IAM
URL="s3://$(BUCKET)/$(TEMPLATE)"

version := $(shell cat version)


environment:
	brew install python@3.9
	brew install awscli
	brew install awscurl
	pip3 install boto3
	pip3 install jinja2


create_bucket:	
	aws s3 mb s3://$(BUCKET) --region $(REGION) || true

check_bucket:
	aws s3 ls s3://$(BUCKET)

upload_template: create_bucket check_bucket
	aws s3 cp $(TEMPLATE) $(URL) --region=$(REGION) --output=yaml

presign: upload_template
	aws s3 presign $(URL) --expires-in 3600 > "url_template.txt"

template_url: 
	$(var) = cat "url_template.txt"
	$(var)

deploy_stack: presign

	aws cloudformation create-stack \
		--stack-name $(STACK) \
		--template-url $(URL_NEW) 
		--capabilities $(CAPABILITIES)


test: 
	echo $(TEST)

all: environment deploy_stack 

get_stacks:  
	aws cloudformation describe-stacks --stack-name $(STACK)


cleanup: 
	aws cloudformation delete-stack --stack-name $(STACK)
	aws s3 rm s3://$(BUCKET) --region $(REGION) --recursive
	aws s3 rb s3://$(BUCKET) --region $(REGION)