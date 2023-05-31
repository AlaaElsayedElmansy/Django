#!/bin/bash

source ./backup_restore_lib.sh

validate_backup_params $1 $2 $3 $4
backup $1 $2 $3 $4
