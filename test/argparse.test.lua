argparse = require('lib/argparse')

parser = argparse.new()
    :add_argument('--user', 'Username', '-u')
    :add_argument('--password', 'Password', '-p')
    :add_argument('--host', 'Host', '-h')
    :add_argument('--port', 'Port', '-P')
    :add_argument('message', 'Message to send')

parser:help()

print()

args, kwargs = parser:parse('-p pw -P 6565 Hello -host 192.168.1.1 -u da-vid')

assert(args.message == 'Hello')
assert(kwargs.user == 'da-vid')
assert(kwargs.password == 'pw')
assert(kwargs.host == '192.168.1.1')
assert(kwargs.port == '6565')

print('Success!')