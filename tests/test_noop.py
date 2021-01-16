from terraform_ci import terraform_apply


def test_noop(ec2_client):
    with terraform_apply("test_data", json_output=True) as tf_out:
        assert 1 == 1
