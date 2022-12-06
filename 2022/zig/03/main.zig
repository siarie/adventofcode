const std = @import("std");

const input = @embedFile("./input.txt");

pub fn main() !void {
    std.debug.print(
        \\AoC D 03: Rucksack Reorganization
        \\  Part 1: {d}
        \\  Part 2: {d}
        \\
    , .{ try part1(), try part2() });
}

fn part1() !usize {
    var split = std.mem.split(u8, input, "\n");
    var total: usize = 0;
    while (split.next()) |line| {
        if (line.len == 0) continue;
        const t = findType(line);
        std.debug.print("{c}\n", .{t});
        const n: u8 = if (std.ascii.isUpper(t)) 38 else 96;
        total += t - n;
    }

    return total;
}

fn part2() !usize {
    var split = std.mem.split(u8, input, "\n");
    var groups = [3][]const u8{ "", "", "" };
    var total: usize = 0;

    var i: usize = 0;
    while (split.rest().len > 1) {
        groups[0] = split.next() orelse break;
        groups[1] = split.next() orelse break;
        groups[2] = split.next() orelse break;

        const t = findTypeGroup(&groups);
        std.debug.print("= {c}\n", .{t});
        const n: u8 = if (std.ascii.isUpper(t)) 38 else 96;
        total += (t - n);

        i = 0;
    }

    return total;
}

fn findTypeGroup(in: [][]const u8) u8 {
    var t: u8 = blk: for (in[0]) |g| {
        for (in[1]) |g1| {
            if (g == g1) {
                for (in[2]) |g2| {
                    if (g == g2) break :blk g;
                }
            }
        }
    };

    return t;
}

fn findType(in: []const u8) u8 {
    const d = in.len / 2;
    const cpart1 = in[0..d];
    const cpart2 = in[d..];

    var t: u8 = blk: for (cpart1) |p1| {
        for (cpart2) |p2| {
            if (p1 == p2) break :blk p1;
        }
    };

    return t;
}
