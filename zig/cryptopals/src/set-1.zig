const std = @import("std");

pub fn loadHex(str: []const u8, output: []u8) void {
    var n: u32 = 0;

    while (n < str.len / 2) : (n += 1) {
        output[n] = std.fmt.parseUnsigned(u8, str[2 * n .. 2 * n + 2], 16) catch 'X';
    }
}

test "loading hex strings" {
    const inputHex: []const u8 = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d";

    var parsedString = try std.testing.allocator.alloc(u8, inputHex.len / 2);
    defer std.testing.allocator.free(parsedString);

    loadHex(inputHex, parsedString);

    try std.testing.expectEqualStrings("I'm killing your brain like a poisonous mushroom", parsedString);
}

test "encoding as Base64" {
    const inputString = "I'm killing your brain like a poisonous mushroom";

    const allocator = std.testing.allocator;
    const Encoder = std.base64.standard.Encoder;
    const encoded_length = Encoder.calcSize(inputString.len);
    const encodedString = try allocator.alloc(u8, encoded_length);
    defer allocator.free(encodedString);

    _ = Encoder.encode(encodedString, inputString);

    try std.testing.expectEqualStrings("SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t", encodedString);
}

pub fn xorStrings(input: []const u8, key: []const u8, output: []u8) void {
    if ((input.len != key.len) or (key.len != output.len)) return;

    var n: usize = 0;
    while (n < input.len) : (n += 1) output[n] = input[n] ^ key[n];
}

test "XOR encryption" {
    const encryptedHex = "1c0111001f010100061a024b53535009181c";
    var encrypted = try std.testing.allocator.alloc(u8, encryptedHex.len / 2);
    defer std.testing.allocator.free(encrypted);
    loadHex(encryptedHex, encrypted);

    const keyHex = "686974207468652062756c6c277320657965";
    var key = try std.testing.allocator.alloc(u8, keyHex.len / 2);
    defer std.testing.allocator.free(key);
    loadHex(keyHex, key);

    var decrypted = try std.testing.allocator.alloc(u8, encryptedHex.len / 2);
    defer std.testing.allocator.free(decrypted);
    xorStrings(encrypted, key, decrypted);

    std.debug.print("Decrypted: {s}.\n", .{decrypted});
}

// AUTO GENERATED

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
