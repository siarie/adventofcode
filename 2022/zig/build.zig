const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    // Day 01
    const d1 = b.addExecutable("aoc22-1", "01/main.zig");
    d1.setTarget(target);
    d1.setBuildMode(mode);
    d1.install();

    const d1_cmd = d1.run();
    d1_cmd.step.dependOn(b.getInstallStep());
    const d1_step = b.step("D1", "Run AoC day 1");
    d1_step.dependOn(&d1_cmd.step);

    // Day 02
    const d2 = b.addExecutable("aoc22-2", "02/main.zig");
    d2.setTarget(target);
    d2.setBuildMode(mode);
    d2.install();

    const d2_cmd = d2.run();
    d2_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        d2_cmd.addArgs(args);
    }

    const d2_step = b.step("D2", "Run AoC day 2");
    d2_step.dependOn(&d2_cmd.step);

    // Day 03
    const d3 = b.addExecutable("aoc22-3", "03/main.zig");
    d3.setTarget(target);
    d3.setBuildMode(mode);
    d3.install();

    const d3_cmd = d3.run();
    d3_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        d3_cmd.addArgs(args);
    }

    const d3_step = b.step("D3", "Run AoC day 3");
    d3_step.dependOn(&d3_cmd.step);
}
