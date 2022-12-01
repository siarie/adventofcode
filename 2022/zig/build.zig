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
}
