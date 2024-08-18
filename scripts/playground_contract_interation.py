from ape import project


def read_simple_storage_value():
    contract = project.SimpleStorage.deployments[-1]
    print(f"stored_value: {contract.retrieve()}")

def get_fund_me_interface_version():
    contract = project.FundMe.deployments[-1]
    print(f"interface_version: {contract.getVersion()}")


def main():
    #read_simple_storage_value()
    get_fund_me_interface_version()