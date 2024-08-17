from ape import accounts, project

def test_deploy():
    my_local_account = accounts.test_accounts[0]
    simple_storage_contract = my_local_account.deploy(project.SimpleStorage)
    expected = 0
    assert simple_storage_contract.retrieve() == expected

def test_updating_storage():
    my_local_account = accounts.test_accounts[0]
    simple_storage_contract = my_local_account.deploy(project.SimpleStorage)
    expected = 15
    simple_storage_contract.store(expected, sender=my_local_account)
    assert simple_storage_contract.retrieve() == expected