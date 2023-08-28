st = require('/disk/lib/setuptools')

st.setup(
    { 'evaporator_controller' },
    { 'peripherals', 'pid', 'term_util' },
    'evaporator_controller'
)
