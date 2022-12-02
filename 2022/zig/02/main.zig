const std = @import("std");
const input = @embedFile("02.txt");

const Result = enum {
    draw,
    loss,
    win,

    pub fn toString(self: Result) []const u8 {
        return switch (self) {
            .draw => "draw",
            .loss => "loss",
            .win => "win",
        };
    }
};
const Shape = enum(u4) {
    rock = 1,
    paper = 2,
    scissor = 3,

    pub fn toString(self: Shape) []const u8 {
        return switch (self) {
            .rock => "rock",
            .paper => "paper",
            .scissor => "scissor",
        };
    }
};

const Round = struct {
    player: Shape,
    opponent: Shape,

    pub fn match(self: Round) Result {
        if (self.player == self.opponent) return .draw;

        // zig fmt: off
        if ((self.player == .rock and self.opponent == .paper)
            or (self.player == .paper and self.opponent == .scissor)
            or (self.player == .scissor and self.opponent == .rock)) return .loss;
        // zig fmt: on

        return .win;
    }

    pub fn score(self: Round) u32 {
        return switch (self.match()) {
            .draw => @enumToInt(self.player) + 3,
            .loss => @enumToInt(self.player),
            .win => @enumToInt(self.player) + 6,
        };
    }
};

pub fn main() !void {
    var arg = std.process.args();
    defer arg.deinit();

    _ = arg.skip(); // skip program name
    const part = arg.next() orelse "asd";

    var score: u32 = 0;
    if (std.mem.eql(u8, part, "-p1")) {
        score = try part1(input);
    } else if (std.mem.eql(u8, part, "-p2")) {
        score = try part2(input);
    }

    std.debug.print("AoC D 02: {d}\n", .{score});
}

fn part1(in: []const u8) !u32 {
    var split = std.mem.split(u8, in, "\n");
    var score: u32 = 0;
    while (split.next()) |line| {
        if (line.len == 0) continue;
        const round = Round{
            .player = try parseShape(line[2]),
            .opponent = try parseShape(line[0]),
        };

        score += round.score();
    }

    return score;
}

fn part2(in: []const u8) !u32 {
    var split = std.mem.split(u8, in, "\n");
    var score: u32 = 0;
    while (split.next()) |line| {
        if (line.len == 0) continue;

        const opponent = try parseShape(line[0]);
        const round = Round{
            .opponent = opponent,
            .player = chooseShape(opponent, line[2]),
        };

        score += round.score();
    }

    return score;
}

fn chooseShape(op: Shape, c: u8) Shape {
    // draw
    if (c == 'Y') return op;

    if (c == 'X') return switch (op) {
        .rock => .scissor,
        .paper => .rock,
        .scissor => .paper,
    };

    return switch (op) {
        .rock => .paper,
        .paper => .scissor,
        .scissor => .rock,
    };
}

fn parseShape(c: u8) error{InvalidShape}!Shape {
    return switch (c) {
        'A', 'X' => .rock,
        'B', 'Y' => .paper,
        'C', 'Z' => .scissor,
        else => error.InvalidShape,
    };
}
