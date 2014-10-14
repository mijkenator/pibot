#!/bin/bash

./rebar compile

cp apps/pibot/ebin/* rel/pibot/lib/pibot-1/ebin/
