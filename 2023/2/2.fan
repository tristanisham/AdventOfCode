// This one isn't finished yet.
import "std/fs" for Fs
import "std/fmt" for Color
// import "std/os" for Runtime

// Game limits:
//    "red": 12,
//    "green": 13,
//    "blue": 14


class Game {
    construct new(id) {
        _id = id
        _red = 0
        _blue = 0
        _green = 0

        _rounds = []
    }

    toConsoleString() {
        return "%(Color.red())%(_red)%(Color.reset()) %(Color.green())%(_green)%(Color.reset()) %(Color.blue())%(_blue)%(Color.reset())"
    }

    red=(value) {_red = value}
    green=(value) {_green = value}
    blue=(value) {_blue =  value}

    id {_id}
    red { _red }
    green { _green }
    blue { _blue }
    rounds {_rounds}

    addRound(red, green, blue) {
        // System.print("%(red) %(green) %(blue)")
        var output = _rounds.add({"red": red, "green": green, "blue": blue})
        // System.print("Saved %(output)")
    }

    isGame1Valid() {
        for (round in _rounds) {
            // System.print("%(this.rounds)")
            var result = true

            if (round["red"] > 12) {
                result = false
            } else if (round["green"] > 13) {
                result = false
            } else if (round["blue"] > 14) {
                result = false
            }

            return result
        }

    }
}


var input = Fs.read("./2/input.txt")
var games = []

for (line in input.split("\n")) {
    var gameId = ""
    var foundColon = false
    var pieces = ""

    // Extract gameId number from line
    for (pt in line.codePoints) {
        // System.write(String.fromCodePoint(pt))
        if (String.fromCodePoint(pt) == ":") {
            foundColon = true
            continue
        }

        if (!foundColon) {
            gameId = gameId + String.fromCodePoint(pt)
        } else {
            pieces = pieces + String.fromCodePoint(pt)
        }
    }
    gameId = gameId.trimStart("Game ")
    // System.print("Game ID: %(gameId)")

    pieces = pieces.trim(" ")
    // System.print(pieces)
    var segments = []
    for (n in pieces.split(" ")) {
        var n_add = n.trim(",").trim(";")
        segments.add(n_add)
    }

    var game = Game.new(Num.fromString(gameId))
    var size = segments.count
    var i = 0
    var input = {"red": 0, "green": 0, "blue": 0}
    while (i < size) {
        if (i % 2 != 0) {
            if (segments[i] == "red") {
                input["red"] = Num.fromString(segments[i-1])
            } else if (segments[i] == "green") {
                input["green"] = Num.fromString(segments[i-1])
            } else if (segments[i] == "blue") {
                input["blue"] = Num.fromString(segments[i-1])
            }
        }

        if ( i != 0 && i % 6 == 0) {
            // System.print("%(i). %(input)")
            game.addRound(input["red"], input["green"], input["blue"])
        }

        i = i + 1
    }

    if (game.isGame1Valid()) {
        // System.print("%(Color.green())Valid:%(Color.reset()) %(game.id)")
        games.add(game)
    }

}

var final = 0

for (game in games) {
    final = final + game.id
}

System.print(final)

