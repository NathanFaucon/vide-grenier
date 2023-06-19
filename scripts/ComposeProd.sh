#!/bin/bash
git checkout master
docker compose build --no-cache
docker compose -p videgrenierenligne-prod up -d