from ape import accounts, project
import json

def deploy_contracts():
    my_local_account = accounts.load("test-sepolia")
    project.FundMe.deploy(0x694AA1769357215DE4FAC081bf1f309aDC325306, sender=my_local_account)
    project.SimpleStorage.deploy(sender=my_local_account)


def main():
    deploy_contracts()

