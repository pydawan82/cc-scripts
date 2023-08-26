require('/lib/term_util')

c = peripheral.wrap('back')
h = peripheral.wrap('top')

pid_package = require('/lib/pid')
pid = pid_package.new(1e2, 1e1, 0, 1)

target = 3000

while true do
    temp = c.getTemperature()
    err = target - temp
    resp = pid:update(err)
    resp = resp < 0 and 0 or resp
    h.setEnergyUsage(resp)

    cls()
    printf('Temperature: %dK', temp)
    printf('Power Usage: %.2fkJ/t', resp / 1000)

    sleep(1)
end
