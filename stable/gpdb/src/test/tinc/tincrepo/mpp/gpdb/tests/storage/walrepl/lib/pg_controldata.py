"""
Copyright (c) 2004-Present Pivotal Software, Inc.

This program and the accompanying materials are made available under
the terms of the under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
"""

from gppylib.commands.base import Command

class PgControlData(object):
    def __init__(self, datadir):
        self.datadir = datadir
        cmd = Command('pg_controldata',
                      '$GPHOME/bin/pg_controldata {0}'.format(datadir))
        cmd.run()
        lookup = {}
        for line in cmd.get_stdout_lines():
            (key, val) = line.split(':', 1)
            key = key.strip()
            val = val.strip()
            lookup[key] = val
        self.lookup = lookup

    def get(self, key):
        return self.lookup[key]
