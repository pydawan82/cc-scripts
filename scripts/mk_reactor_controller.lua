require('/lib/term_util')
peripherals = require('/lib/peripherals')
pids = require('/lib/pid')

r = peripherals.wrap('back')

pid = pids.new(2e1, 5e-1, 0, 1)

target = 0.5
max_burn = 100

while true do
    f = r.getCoolantFilledPercentage()

    if r.getStatus() then
        err = target - f
        resp = -pid:update(err)
        resp = resp < 0 and 0 or resp
        resp = resp > max_burn and max_burn or resp
        r.setBurnRate(resp)
    end

    br = r.getBurnRate()

    cls()
    printf('Filled: %d%%', f * 100)
    printf('Burn rate: %.2fmB/t', br)

    if r.getStatus() and f < 0.1 then
        r.setBurnRate(0)
        r.scram()
        print('Too few coolant, scramming reactor!')
    end

    sleep(1)
end
