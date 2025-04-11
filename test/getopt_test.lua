getopts = require('lib.getopts')

parser = getopts.new()
    :add_argument('user', 'u', 'Username')
    :add_argument('password', 'p', 'Password')
    :add_argument('host', 'h', 'Host')
    :add_argument('port', 'P', 'Port')
    :add_argument('debug', 'g', 'Use debugging symbols')

parser:help()

args, opts, errors = parser:parse_line('-ppw -P6565 Hello --host=192.168.1.1 -uda-vid --debug')

assert(#errors == 0)
assert(#args == 1)
assert(args[1] == 'Hello')
assert(opts.user == 'da-vid')
assert(opts.password == 'pw')
assert(opts.host == '192.168.1.1')
assert(opts.port == '6565')
assert(opts.debug)

print('Success!')