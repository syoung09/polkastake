# polkastake

Used to build a pair of Polkadot fullnodes in AWS; one region, two AZs.

To run the playbook serially one node at a time pass `-e serialvar=1` in the ansible-playbook command.

Fullnodes can be quickly upgraded with minimal downtime by changing the *node_binary_version* in `inventory.yml` to the desired version then running the playbook as usual.


References
------------

[Run a Validator (Polkadot)](https://wiki.polkadot.network/docs/maintain-guides-how-to-validate-polkadot)

[Upgrade a Validator](https://wiki.polkadot.network/docs/maintain-guides-how-to-upgrade)

[Polkadot Repo](https://github.com/paritytech/polkadot)

[Paritytech Ansible Role](https://github.com/paritytech/ansible-galaxy)

[Binaries](https://github.com/paritytech/polkadot/releases)

