from ape import accounts, project

def deploy_simple_storage():
    my_account = accounts.load("test-sepolia")
    simple_storage_contract = my_account.deploy(project.SimpleStorage)
    print(simple_storage_contract)

def main():
    deploy_simple_storage()