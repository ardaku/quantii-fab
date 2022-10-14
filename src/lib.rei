#*
    Quantii Printer Drivers
*#

// wait, so we have a 32-bit ucontroller thats executing the g code?

// use usb-c (3.1+) for bidir comms

// either through USB or some "port" I think...
// treat as serial?

send_job: async (job: Job, usb_port: UsbPort) {
    let raw_data = job.to_bytes()
    usb_port.write(raw_data)
}

// uses neutronapi usb drivers

use neutronapi::device::usb::*

@derive(Serialize)
Job: enum {
    PrintSpec: {
        Vec[GCode]
    }
    // manual tuning, usually gcode
    // allow de-enumeration?
    ...GCode
}

@derive(Deserialize)
Response: {}

Axis: X | Y | Z

Step: f64

Context: Bed | Head

GCode: enum {
    Move: (Step, Axis)
    Temp: (Step, Context)
}

// let gcode = GCode::Move()
// gcode.Step == gcode[0]
