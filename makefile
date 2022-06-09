USER=hkozu
STACK=$(USER)-ec2-stack-full
BUCKET=$(USER)-s3-bucket
REGION=eu-central-1
TEMPLATE="cloudformation_template.yaml"
CAPABILITIES=CAPABILITY_NAMED_IAM
URL="s3://$(BUCKET)/$(TEMPLATE)"



create_bucket:	
	aws s3 mb s3://$(BUCKET) --region $(REGION) || true

package: create_bucket
	alias pip=pip3
	pip install --target ./lambda_function -r ./lambda_function/requirements.txt
	aws cloudformation package \
		--template ./external-stack.yaml \
		--s3-bucket $(BUCKET) \
		--output-template-file packaged-stack.yaml


check_bucket:
	aws s3 ls s3://$(BUCKET)

upload_template:
	aws s3 cp $(TEMPLATE) $(URL) --region=$(REGION) --output=yaml

presign: upload_template
	aws s3 presign $(URL) --expires-in 3600 > "url_template.txt"

deploy_stack: presign
	
	aws cloudformation create-stack \
		--stack-name $(STACK) \
		--template-url $(TEMPLATE_URL)\
		--capabilities $(CAPABILITIES)

cleanup: 
	aws cloudformation delete-stack --stack-name $(STACK)
	aws s3 rm s3://$(BUCKET) --region $(REGION) --recursive

all: deploy_stack