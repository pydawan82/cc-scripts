require('debug.inspect')
require('lib.strings')

ft = require('lib.functools')
it = require('lib.itertools')

assert(strings.join({
    'Hello ', 'World, ', 'this is me'
    }) == 'Hello World, this is me')

assert(#strings.tobuffer('Hello World!') == 12)
assert(table.concat(strings.tobuffer('Hello World!')) == 'Hello World!')

res = strings.split('Hello,World,this,is,me,', ',')
exp = {'Hello', 'World', 'this', 'is', 'me', ''}
for l, r in it.zip(res, exp) do
    assert(l == r)
end

res = strings.split('Hello,World,this,is,me', ',')
exp = {'Hello', 'World', 'this', 'is', 'me'}
for l, r in it.zip(res, exp) do
    assert(l == r)
end