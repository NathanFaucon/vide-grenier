#!/bin/bash
git checkout pre-pod
docker compose build --no-cache
docker compose -p videgrenierenligne-pre-prod up -d