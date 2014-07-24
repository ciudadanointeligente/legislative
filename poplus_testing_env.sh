#!/bin/bash

set -e

echo "Running the POPLUS components for the testing environment"
./poplus_components/start_local_billit.bash
./poplus_components/start_local_popit_api.bash
./poplus_components/start_local_writeit.bash