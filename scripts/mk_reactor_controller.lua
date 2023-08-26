require('/lib/term_util')

r = peripheral.wrap('back')

pid_package = require('/lib/pid')
pid = pid_package.new(-10e0, -2e0, 0, 1)

target = 0.5
max_burn = 100

while true do
    f = r.getCoolantFilledPercentage()

    if r.getStatus() then
        err = target - f
        resp = pid:update(err)
        resp = resp < 0 and 0 or resp
        resp = resp > max_burn and max_burn or resp
        r.setBurnRate(resp)
    end

    br = r.getBurnRate()

    cls()
    printf('Filled: %d%%', f * 100)
    printf('Burn rate: %.2fmB/t', br)

    if f < 0.1 then
        r.scram()
        print('Too few coolant, scramming reactor!')
        return -1
    end
    sleep(1)
end
