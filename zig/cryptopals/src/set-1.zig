const std = @import("std");

pub fn loadHex(str: []const u8, output: []u8) void {
    var n: u32 = 0;

    while (n < str.len / 2) : (n += 1) {
        output[n] = std.fmt.parseUnsigned(u8, str[2 * n .. 2 * n + 2], 16) catch 'X';
    }
}

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    // stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("Run `zig build test` to run the tests.\n", .{});

    try bw.flush(); // don't forget to flush!
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}

test "loading hex strings" {
    const inputHex: []const u8 = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d";

    var parsedString = try std.testing.allocator.alloc(u8, inputHex.len / 2);
    defer std.testing.allocator.free(parsedString);

    loadHex(inputHex, parsedString);

    try std.testing.expectEqualStrings("I'm killing your brain like a poisonous mushroom", parsedString);
}
