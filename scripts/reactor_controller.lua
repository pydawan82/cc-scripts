r = peripheral.wrap('back')
pid_package = require('/lib/pid')
pid = pid_package.new(1e-2, 1e-2, 0, 1)
target = 2000

while true do
    temp = r.fuelTemperature()
    print(temp)
    err = target - temp
    resp = pid:update(err)
    r.setAllControlRodLevels(100 - resp)

    sleep(1)
end
