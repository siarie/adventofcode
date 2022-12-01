const std = @import("std");

const data = @embedFile("./01.txt");

pub fn main() !void {
    var input = std.mem.split(u8, data, "\n");

    // Top three calories
    var tcal = [3]u32{ 0, 0, 0 };

    var total: u32 = 0;
    while (input.next()) |v| {
        if (v.len == 0) {
            // Just need to get the top 3, so I think don't need to use sort
            if (total > tcal[0]) {
                tcal[2] = tcal[1];
                tcal[1] = tcal[0];
                tcal[0] = total;
            } else if (total > tcal[1]) {
                tcal[2] = tcal[1];
                tcal[1] = total;
            } else if (total > tcal[2]) {
                tcal[2] = total;
            }

            total = 0;
            continue;
        }

        const cal = try std.fmt.parseUnsigned(u32, v, 10);
        total += cal;
    }

    std.debug.print(
        \\AoC D01:
        \\|- Part 1: {d}
        \\|- Part 2: {d}
        \\
    , .{
        tcal[0],
        sum(&tcal),
    });
}

fn sum(items: []u32) u32 {
    var total: u32 = 0;
    for (items) |n| {
        total += n;
    }

    return total;
}
