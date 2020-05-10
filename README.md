# SERVICE INFRA
 Setup Service Infra

# First-Step:
 At fist "terraform-state-s3" folder is executed, which creates backend-s3 used for storinf terraform-state files


# Second-Step:
As a second step, we will execute "service-jenkins-batch" folder, which creates our jenkins-batch server
Note: we will install packer also in batch-jenkins server via user data


# Third-Step:
After  jenkins-batch server is running, we will login to server via console and create 2 jobs.
## first jenkins job:
-First Job is for packer-build , which build the packer and will send the ami_vars.tf file to s3.(code is from app-repo)
### script for first Job:
    ARTIFACT=`packer build -machine-readable packer-jenkins.json |awk -F, '$0 ~/artifact,0,id/ {print $6}'`
    AMI_ID=`echo $ARTIFACT | cut -d ':' -f2`
    echo 'variable "API_INSTANCE_AMI" { default = "'${AMI_ID}'" }' > amivar.tf
    aws s3 cp amivar.tf s3://devops-terraform-state-galaxy/vars/amivar.tf

Note: This packer-jenkins.json nned to be present in github-path for the job(app-code-github-path)


## second-jenkins-job:
-Second job is for terraform apply, which gets the code from github on "services" folder and then copies file("ami_vars.tf") from s3, and 
 then execute the terraform script

### script for second Job:
    cd services
    aws s3 cp s3://devops-terraform-state-galaxy/vars/amivar.tf  amivar.tf
    terraform apply -auto-approve -var password="YourRdsPassword" -target module.db


## Resources:
https://blog.gruntwork.io/how-to-manage-terraform-state-28f5697e68fa
https://github.com/wardviaene/terraform-course/tree/master/jenkins-packer-demo

