local P = {}
pid = P

local function pid.new(kp, ki, kd, dt)
    return {
        __index = pid,
        kp = kp,
        ki = ki,
        kd = kd,
        dt = dt,
        integral = 0,
        last_error = 0
    }
end

local function pid.update(pid, err)
    local p = pid.kp * err
    local i = pid.ki * pid.integral
    local d = pid.kd * (err - pid.last_error) / pid.dt

    pid.integral = pid.integral + err * pid.dt
    pid.last_error = err

    return p + i + d
end

return pid