from ape import project


def read_value():
    contract = project.SimpleStorage.deployments[-1]
    print(f"stored_value: {contract.retrieve()}")

def main():
    read_value()