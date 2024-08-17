from ape import accounts, project


def deploy_simple_storage():
    #my_test_account = accounts.load("test-sepolia")
    my_local_account = accounts.test_accounts[0]
    simple_storage_contract = my_local_account.deploy(project.SimpleStorage)
    stored_value = simple_storage_contract.retrieve()
    print(f"stored_value: {stored_value}")
    tx = simple_storage_contract.store(15, sender=my_local_account)
    print(f"xt: {tx}")
    print(f"retrieve: {simple_storage_contract.retrieve()}")



def main():
    deploy_simple_storage()

