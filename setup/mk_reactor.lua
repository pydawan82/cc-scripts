st = require('../lib/setuptools')

st.setup(
    { 'mk_reactor_controller' },
    { 'peripherals', 'pid', 'term_util' },
    'mk_reactor_controller'
)
