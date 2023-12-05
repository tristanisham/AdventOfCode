import "std/fs" for Fs
import "std/fmt" for Fmt
// import "std/os" for Runtime

var textNum = Fn.new { |input, reverse|
    if (!(input is String)) {
        Fiber.abort("Paramater must be of type String")
    }

    // This is where I'd make the input all lowercase if Fan had that in its standard library 😂
    if (reverse) {
        input = Fmt.reverse(input)
    } 


    // System.print("Input: %(input)")

    var index = [
        "zero",
        "one",
        "two",
        "three",
        "four",
        "five",
        "six",
        "seven",
        "eight",
        "nine"
    ]

    var keys = {
        "zero": 0,
        "one": 1,
        "two": 2,
        "three": 3,
        "four": 4,
        "five": 5,
        "six": 6,
        "seven": 7,
        "eight": 8,
        "nine": 9
    }


    for (i in index) {
        if (input.contains(i)) {
            return keys[i]

        }
    }

    return null
}

var input = Fs.read("./1/input.txt")

var output = []

for (line in input.split("\n")) {

    var fromStart = Fiber.new {
        var buffer = ""
        for (i in line) {
            if (buffer.count >= 3) {
                var strKeys = textNum.call(buffer, false)

                if (strKeys is Num) {
                    // System.print("Found \e[0;32m%(strKeys)\e[0m")
                    Fiber.yield(strKeys)
                }
            }

            

            var diget = Num.fromString(i)
            if (diget != null) {
                Fiber.yield(diget)
            }

            buffer = buffer + i
        }
    }

    var fromEnd = Fiber.new {
        var buffer = ""
        var size = line.count
        while (size != 0) {
            if (buffer.count >= 3) {
                var strKeys = textNum.call(buffer, true)

                 if (strKeys is Num) {
                    // System.print("Found \e[0;32m%(strKeys)\e[0m")
                    Fiber.yield(strKeys)
                }
            }

           
            var letter = line[size-1]
            var diget = Num.fromString(letter)
            if (diget != null) {
                Fiber.yield(diget)
            }

            buffer = buffer + letter
            size = size-1
        }
    }

    if (!fromStart.isDone && !fromEnd.isDone) {
        var start = fromStart.call()
        var end = fromEnd.call()

        System.print("\e[0;32m%(start)\e[0m %(line) \e[0;32m%(end)\e[0m")


        var target = "%(start)%(end)"
        
        var diget = Num.fromString(target)
        
     
        
        if (diget != null) {
            output.add(diget)
        }
    }
    
}

var final = 0

for (int in output) {
    final = final + int
}

System.print("--------------------------------")
System.print(final)