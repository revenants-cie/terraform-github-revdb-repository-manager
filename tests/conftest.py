import boto3
import pytest
from terraform_ci import setup_environment

TEST_ACCOUNT = "114198773012"
REGION = "us-east-2"
# setup terraform environment
setup_environment()

assert boto3.client("sts").get_caller_identity().get("Account") == TEST_ACCOUNT


@pytest.fixture(scope="session")
def asg_client():
    asg = boto3.client("autoscaling", region_name=REGION)
    return asg


@pytest.fixture()
def ec2_client():
    ec2 = boto3.client("ec2", region_name=REGION)
    return ec2
