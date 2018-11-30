#!/bin/bash
# Fail on any error
set -e

fog apply -d users
fog apply -d groups
