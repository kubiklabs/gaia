#!/bin/bash

make install JUNO_BUILD_OPTIONS="cleveldb"

junod init "t6" --home ./t6 --chain-id t6

junod unsafe-reset-all --home ./t6

mkdir -p ./t6/data/snapshots/metadata.db

junod keys add validator --keyring-backend test --home ./t6

junod add-genesis-account $(junod keys show validator -a --keyring-backend test --home ./t6) 100000000stake --keyring-backend test --home ./t6

junod gentx validator 100000000stake --keyring-backend test --home ./t6 --chain-id t6

junod collect-gentxs --home ./t6

junod start --db_backend cleveldb --home ./t6
