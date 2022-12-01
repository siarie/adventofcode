const std = @import("std");
const mem = std.mem;

const data = @embedFile("./01.txt");

pub fn main() !void {
    var input = mem.split(u8, data, "\n");

    var calories = std.ArrayList(u32).init(std.heap.page_allocator);
    defer calories.deinit();

    var total: u32 = 0;
    while (input.next()) |v| {
        if (v.len == 0) {
            try calories.append(total);
            total = 0;
            continue;
        }

        const cal = try std.fmt.parseUnsigned(u32, v, 10);
        total += cal;
    }

    std.debug.print("AoC D01: {d}\n", .{std.mem.max(u32, calories.items)});
}
