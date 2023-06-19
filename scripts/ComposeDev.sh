#!/bin/bash
git checkout dev
docker compose build --no-cache
docker compose -p videgrenierenligne-dev up -d