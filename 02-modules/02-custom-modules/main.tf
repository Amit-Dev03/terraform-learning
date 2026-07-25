#Now we have to create 3 infra -> 1. dev 2. prod and 3. staging 
#Hence we need to create 3 separate module blocks 

#dev-infra creation 
module "dev-infra" {
    source = "./app-infra" #path of the module

    #open the variable.tf into side in vs code and fill the values
    env = "dev"
    bucket_name = "dev-infra-buckety" #bucket name should be globally unique
    instance_count = 1
    instance_type = "t3.micro"
    ami_id = "ami-01a00762f46d584a1" #ami id for ubuntu instance in ap-south-1 region
}

#prod-infra creation 
module "prod-infra" {
    source = "./app-infra" #path of the module

    #open the variable.tf into side in vs code and fill the values
    env = "prod"
    bucket_name = "prod-infra-buckety" #bucket name should be globally unique
    instance_count = 2
    instance_type = "t3.micro"
    ami_id = "ami-01a00762f46d584a1" #ami id for ubuntu instance in ap-south-1 region
}

#staging-infra creation 
module "staging-infra" {
    source = "./app-infra" #path of the module

    #open the variable.tf into side in vs code and fill the values
    env = "staging"
    bucket_name = "staging-infra-buckety" #bucket name should be globally unique
    instance_count = 1
    instance_type = "t3.small"
    ami_id = "ami-01a00762f46d584a1" #ami id for ubuntu instance in ap-south-1 region
}