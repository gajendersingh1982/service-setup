# SERVICE INFRA
 Setup Service Infra

## First-Step:
 At fist "terraform-state-s3" folder is executed, which creates backend-s3 used for storing terraform-state files
 - Fist execute with local state file
 - Then execute with State file as S3 so that transfer of state file happens

## Second-Step:
As a second step, we will excute "network" folder, which creates our network like vpc, etc.

## Third-Step:
-Move into packer folder to build our golden AMI's.(packer build can be ran in local machine)
  -- packer build batch.json
-Transfer "was.json" file to your application code folder(your app repo) so that you can execute in later stage(in Fifth step as "- packer build was.json" )

## Fourth-Step:
As a fourth step, we will execute "batch" folder, which creates our jenkins-batch server
Note: Following willbe installed on this:
- Java 11 Open JDK
- Jenkins
- Packer
- Terraform

## Fifth-Step:
After  jenkins-batch server is running, we will login to server via http and create jobs.
- All Build Jenkins Job will be written in Jenkins Pipeline (Groovy)

### first jenkins job:
- First Job is for packer-build , which build the packer and will send the ami_vars.tf file to s3.(code is from app-repo)
#### script for first Job:
    ARTIFACT=`packer build -machine-readable was.json |awk -F, '$0 ~/artifact,0,id/ {print $6}'`
    AMI_ID=`echo $ARTIFACT | cut -d ':' -f2`
    echo 'variable "API_INSTANCE_AMI" { default = "'${AMI_ID}'" }' 

Note: This was.json need to be present in github-path for the job(app-code-github-path)-(Refer Third step).

### second-jenkins-job:
- Second job is for terraform apply, which gets the code from github on "services" folder and then execute the terraform script

#### script for second Job:
    cd services
    terraform init
    terraform plan
    terraform apply -auto-approve -var password="YourRdsPassword" -target module.db

### Resources:
https://blog.gruntwork.io/how-to-manage-terraform-state-28f5697e68fa
https://github.com/wardviaene/terraform-course/tree/master/jenkins-packer-demo

