// This one isn't finished yet.
import "std/fs" for Fs
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
    }

    red=(value) {_red = _red + value}
    green=(value) {_green = _green + value}
    blue=(value) {_blue = _blue + value}

    id {_id}
    red { _red }
    green { _green }
    blue { _blue }

    isGame1Valid() {
       return !(_red > 12 || _green > 13 || _blue > 14)
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
    while (i < size) {
        if (i % 2 != 0) {
            if (segments[i] == "red") {
                game.red = Num.fromString(segments[i-1])
            } else if (segments[i] == "green") {
                game.green = Num.fromString(segments[i-1])
            } else if (segments[i] == "blue") {
                game.blue = Num.fromString(segments[i-1])
            }
        }

        i = i + 1
    }

    if (game.isGame1Valid()) {
        System.print(game.id)
        games.add(game)
    }

}

var final = 0

for (game in games) {
    final = final + game.id
}

System.print(final)