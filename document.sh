#!/bin/sh
sourcekitten doc --spm --module-name HSHelpers > .tmp/mod1.json
sourcekitten doc --spm --module-name HSAppKit > .tmp/mod2.json
sourcekitten doc --spm --module-name HSUIKit > .tmp/mod3.json
sourcekitten doc --spm --module-name HSTime > .tmp/mod4.json
jazzy --sourcekitten-sourcefile .tmp/mod1.json,.tmp/mod2.json,.tmp/mod3.json,.tmp/mod4.json