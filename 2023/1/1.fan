import "std/fs" for Fs
import "std/os" for Runtime

var input = Fs.read("./1/input.txt")

var output = []

for (line in input.split("\n")) {

    var fromStart = Fiber.new {
        for (i in line) {
            var diget = Num.fromString(i)
            if (diget != null) {
                Fiber.yield(diget)
            }
        }
    }

    var fromEnd = Fiber.new {
        var size = line.count
        while (size >= 0) {
            var diget = Num.fromString(line[size-1])
            if (diget != null) {
                Fiber.yield(diget)
            }

            size = size-1
        }
    }

    if (!fromStart.isDone && !fromEnd.isDone) {
        var start = fromStart.call()
        var end = fromEnd.call()

        var typeStart = Runtime.typeOf(start)
        var typeEnd = Runtime.typeOf(end)

        System.print("%(start): %(typeStart) + %(end): %(typeEnd)")

        var target = "%(start)%(end)"
        
        var diget = Num.fromString(target)
        
        var typeDiget = Runtime.typeOf(diget)
        System.print("%(diget): %(typeDiget)")
        
        if (diget != null) {
            System.print("Extracted %(diget)")
            output.add(diget)
        }
    }
    
}

var final = 0

for (int in output) {
    final = final + int
}

System.print(final)